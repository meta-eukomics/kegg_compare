library(ggplot2)

comb <- read.csv('combined_output.csv')
comb <- comb[,2:ncol(comb)]

# Fix orfs with no taxonomy
comb[is.na(comb$sample),]$sample <- sapply(strsplit(comb[is.na(comb$sample),]$orf, split="_"), function(x) x[2])

comb_collapse <- comb %>%
  group_by(sample, level4, KO) %>%
  summarise(TPM = sum(TPM))

ggplot(data = comb_collapse, aes(x = sample, y =  TPM, fill = level4)) +
  facet_wrap(~ KO, scales = "free_y") +
  geom_bar(stat = "identity")


# no bacteria
comb_filt <- comb %>%
  filter(level1 == "Eukaryota")

comb_filt_collapse <- comb_filt %>%
  group_by(sample, level4, KO) %>%
  summarise(TPM = sum(TPM))

comb_filt_collapse$KO <- factor(comb_filt_collapse$KO, levels = c("K02575", "K10534", "K02217", "K01126"))
ggplot(data = comb_filt_collapse, aes(x = sample, y =  TPM, fill = level4)) +
  facet_wrap(~ KO, scales = "free_y") +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# dinos only
comb_filt_dinos <- comb_filt %>%
  filter(level4 == "Dinophyceae") %>%
  filter(KO %in% c('K02575', 'K10534'))

comb_filt_dinos_collapse <- comb_filt_dinos %>%
  group_by(sample, level4, KO) %>%
  summarise(TPM = sum(TPM))

ggplot(data = comb_filt_dinos_collapse, aes(x = sample, y =  TPM, fill = level4)) +
  facet_wrap(~ KO, scales = "free_y") +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
