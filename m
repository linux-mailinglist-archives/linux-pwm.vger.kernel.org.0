Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC272B68F4
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Nov 2020 16:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgKQPo1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Nov 2020 10:44:27 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:42957 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgKQPo0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Nov 2020 10:44:26 -0500
Received: from orion.localdomain ([95.118.38.12]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MDyoU-1kXJMy0VJE-009uWD; Tue, 17 Nov 2020 16:43:44 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        andrew@aj.id.au, albeu@free.fr, f.fainelli@gmail.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        Eugeniy.Paltsev@synopsys.com, hoan@os.amperecomputing.com,
        fancer.lancer@gmail.com, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com, vz@mleia.com,
        marek.behun@nic.cz, matthias.bgg@gmail.com,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org,
        manivannan.sadhasivam@linaro.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] drivers: gpio: use of_match_ptr() and ACPI_PTR() macros
Date:   Tue, 17 Nov 2020 16:43:40 +0100
Message-Id: <20201117154340.18216-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:Ia6CbPYFrNouPvD28rPqS4ZoQkjqxULHZZAHLOKBJu91JOAFMZY
 NDjoU3fxvNWFCLNUUPIa9JSG8VoNRBPm/U6CTNDzansyUoLQey71DJk36E9AIJW3ZKaWtcz
 +5y8oiuXRL2k8y7DD9GH4BJ9kjCnAlUq7zRzteWqJ9sL6JXMca6QOxyQfHxHtlfi7xTl+aA
 7IFRE0OsYlfca0zm+jy/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ESw0x7iCys8=:sCiLlkze+KEDotJZLxCSNd
 qYwgqNnMcwjKJxdBw1p6mfgEWfjhMPd+cm82QdLv7oItDl9TYLdTFHHuz0C14Ng3v3nB+nkoj
 gYvEzC8mGHpQpbcrE866yWUiWBReljZswA1mXJ5hURxKpWf4vFQhoiyN84DECO+Wn5GOCCb/k
 5fx1Aq+oKb4PTmJF8wSQzVmfnwixFXXJH4QLq8ihFOn/l+1v6R+z+j2ytTFQHZX2Ziz9XGp8R
 wJTfyOru0RiYdxK7y0Bg3heAkFQQPUdKl0H2e9U+Mt7DSJfXuOuFqWl6az4l++QbGmHEvGImj
 RixnwD6h/CygeGP2/9Et1OBAEtp69P7d0/lVS9Zxe8KHkgK/DZkoZuL9F5/ttDCZ0VZ6X6ZPN
 FiVgQ8FUfT04JYFrtmp95mittrcXqcqa9Vsnx6ILDEC9SzUE0UXKmWYJzGb9S
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The of_match_ptr(foo) macro evaluates to foo, only if
CONFIG_OF is set, otherwise to NULL. Same does ACPI_PTR with
CONFIG_ACPI. That's very helpful for drivers that can be used
with or without oftree / acpi.

Even though most of the drivers touched here probably don't
actually need that, it's also nice for consistency to make it
the de-facto standard and change all drivers to use the
of_match_ptr() and ACPI_PTR() macros.

A nice side effect: in some situations, when compiled w/o
CONFIG_OF/CONFIG_ACPI, the corresponding match tables could
automatically become unreferenced and optimized-away by the
compiler, w/o explicitly cluttering the code w/ ifdef's.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-74x164.c        | 2 +-
 drivers/gpio/gpio-74xx-mmio.c     | 2 +-
 drivers/gpio/gpio-adnp.c          | 2 +-
 drivers/gpio/gpio-aspeed-sgpio.c  | 2 +-
 drivers/gpio/gpio-aspeed.c        | 2 +-
 drivers/gpio/gpio-ath79.c         | 2 +-
 drivers/gpio/gpio-bcm-kona.c      | 2 +-
 drivers/gpio/gpio-brcmstb.c       | 2 +-
 drivers/gpio/gpio-cadence.c       | 2 +-
 drivers/gpio/gpio-creg-snps.c     | 2 +-
 drivers/gpio/gpio-dwapb.c         | 4 ++--
 drivers/gpio/gpio-eic-sprd.c      | 2 +-
 drivers/gpio/gpio-em.c            | 2 +-
 drivers/gpio/gpio-ge.c            | 2 +-
 drivers/gpio/gpio-grgpio.c        | 2 +-
 drivers/gpio/gpio-gw-pld.c        | 2 +-
 drivers/gpio/gpio-hlwd.c          | 2 +-
 drivers/gpio/gpio-logicvc.c       | 2 +-
 drivers/gpio/gpio-lp3943.c        | 2 +-
 drivers/gpio/gpio-lpc18xx.c       | 2 +-
 drivers/gpio/gpio-mb86s7x.c       | 2 +-
 drivers/gpio/gpio-mm-lantiq.c     | 2 +-
 drivers/gpio/gpio-moxtet.c        | 2 +-
 drivers/gpio/gpio-mpc5200.c       | 4 ++--
 drivers/gpio/gpio-mpc8xxx.c       | 2 +-
 drivers/gpio/gpio-mt7621.c        | 2 +-
 drivers/gpio/gpio-mvebu.c         | 2 +-
 drivers/gpio/gpio-mxc.c           | 2 +-
 drivers/gpio/gpio-mxs.c           | 2 +-
 drivers/gpio/gpio-octeon.c        | 2 +-
 drivers/gpio/gpio-omap.c          | 2 +-
 drivers/gpio/gpio-palmas.c        | 2 +-
 drivers/gpio/gpio-pca953x.c       | 4 ++--
 drivers/gpio/gpio-pca9570.c       | 2 +-
 drivers/gpio/gpio-pisosr.c        | 2 +-
 drivers/gpio/gpio-pmic-eic-sprd.c | 2 +-
 drivers/gpio/gpio-rda.c           | 2 +-
 drivers/gpio/gpio-sl28cpld.c      | 2 +-
 drivers/gpio/gpio-spear-spics.c   | 2 +-
 drivers/gpio/gpio-sprd.c          | 2 +-
 drivers/gpio/gpio-stp-xway.c      | 2 +-
 drivers/gpio/gpio-syscon.c        | 2 +-
 drivers/gpio/gpio-tb10x.c         | 2 +-
 drivers/gpio/gpio-tegra.c         | 2 +-
 drivers/gpio/gpio-tegra186.c      | 2 +-
 drivers/gpio/gpio-tpic2810.c      | 2 +-
 drivers/gpio/gpio-ts4800.c        | 2 +-
 drivers/gpio/gpio-ts4900.c        | 2 +-
 drivers/gpio/gpio-twl4030.c       | 2 +-
 drivers/gpio/gpio-uniphier.c      | 2 +-
 drivers/gpio/gpio-vf610.c         | 2 +-
 drivers/gpio/gpio-wcd934x.c       | 2 +-
 drivers/gpio/gpio-xgene-sb.c      | 2 +-
 drivers/gpio/gpio-xgene.c         | 2 +-
 drivers/gpio/gpio-xgs-iproc.c     | 2 +-
 drivers/gpio/gpio-xilinx.c        | 2 +-
 drivers/gpio/gpio-xlp.c           | 2 +-
 drivers/gpio/gpio-zevio.c         | 2 +-
 drivers/gpio/gpio-zynq.c          | 2 +-
 59 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index 05637d585152..f9693e51eaa9 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -184,7 +184,7 @@ MODULE_DEVICE_TABLE(of, gen_74x164_dt_ids);
 static struct spi_driver gen_74x164_driver = {
 	.driver = {
 		.name		= "74x164",
-		.of_match_table	= gen_74x164_dt_ids,
+		.of_match_table	= of_match_ptr(gen_74x164_dt_ids),
 	},
 	.probe		= gen_74x164_probe,
 	.remove		= gen_74x164_remove,
diff --git a/drivers/gpio/gpio-74xx-mmio.c b/drivers/gpio/gpio-74xx-mmio.c
index 173e06758e6c..076ff73764f3 100644
--- a/drivers/gpio/gpio-74xx-mmio.c
+++ b/drivers/gpio/gpio-74xx-mmio.c
@@ -138,7 +138,7 @@ static int mmio_74xx_gpio_probe(struct platform_device *pdev)
 static struct platform_driver mmio_74xx_gpio_driver = {
 	.driver	= {
 		.name		= "74xx-mmio-gpio",
-		.of_match_table	= mmio_74xx_gpio_ids,
+		.of_match_table	= of_match_ptr(mmio_74xx_gpio_ids),
 	},
 	.probe	= mmio_74xx_gpio_probe,
 };
diff --git a/drivers/gpio/gpio-adnp.c b/drivers/gpio/gpio-adnp.c
index 8eedfc6451df..a36b6ab7e9cf 100644
--- a/drivers/gpio/gpio-adnp.c
+++ b/drivers/gpio/gpio-adnp.c
@@ -534,7 +534,7 @@ MODULE_DEVICE_TABLE(of, adnp_of_match);
 static struct i2c_driver adnp_i2c_driver = {
 	.driver = {
 		.name = "gpio-adnp",
-		.of_match_table = adnp_of_match,
+		.of_match_table = of_match_ptr(adnp_of_match),
 	},
 	.probe = adnp_i2c_probe,
 	.id_table = adnp_i2c_id,
diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index 64e54f8c30d2..085bf790c5f9 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -564,7 +564,7 @@ static int __init aspeed_sgpio_probe(struct platform_device *pdev)
 static struct platform_driver aspeed_sgpio_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
-		.of_match_table = aspeed_sgpio_of_table,
+		.of_match_table = of_match_ptr(aspeed_sgpio_of_table),
 	},
 };
 
diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index b966f5e28ebf..ad60bdfd22df 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1244,7 +1244,7 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 static struct platform_driver aspeed_gpio_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
-		.of_match_table = aspeed_gpio_of_table,
+		.of_match_table = of_match_ptr(aspeed_gpio_of_table),
 	},
 };
 
diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
index d5359341cc6b..830978feb5b0 100644
--- a/drivers/gpio/gpio-ath79.c
+++ b/drivers/gpio/gpio-ath79.c
@@ -301,7 +301,7 @@ static int ath79_gpio_probe(struct platform_device *pdev)
 static struct platform_driver ath79_gpio_driver = {
 	.driver = {
 		.name = "ath79-gpio",
-		.of_match_table	= ath79_gpio_of_match,
+		.of_match_table	= of_match_ptr(ath79_gpio_of_match),
 	},
 	.probe = ath79_gpio_probe,
 };
diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 1e6b427f2c4a..9838363e3117 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -667,7 +667,7 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
 static struct platform_driver bcm_kona_gpio_driver = {
 	.driver = {
 			.name = "bcm-kona-gpio",
-			.of_match_table = bcm_kona_gpio_of_match,
+			.of_match_table = of_match_ptr(bcm_kona_gpio_of_match),
 	},
 	.probe = bcm_kona_gpio_probe,
 };
diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index fcfc1a1f1a5c..8e27374d5a80 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -814,7 +814,7 @@ MODULE_DEVICE_TABLE(of, brcmstb_gpio_of_match);
 static struct platform_driver brcmstb_gpio_driver = {
 	.driver = {
 		.name = "brcmstb-gpio",
-		.of_match_table = brcmstb_gpio_of_match,
+		.of_match_table = of_match_ptr(brcmstb_gpio_of_match),
 		.pm = &brcmstb_gpio_pm_ops,
 	},
 	.probe = brcmstb_gpio_probe,
diff --git a/drivers/gpio/gpio-cadence.c b/drivers/gpio/gpio-cadence.c
index a4d3239d2594..7920d38ed794 100644
--- a/drivers/gpio/gpio-cadence.c
+++ b/drivers/gpio/gpio-cadence.c
@@ -282,7 +282,7 @@ static const struct of_device_id cdns_of_ids[] = {
 static struct platform_driver cdns_gpio_driver = {
 	.driver = {
 		.name = "cdns-gpio",
-		.of_match_table = cdns_of_ids,
+		.of_match_table = of_match_ptr(cdns_of_ids),
 	},
 	.probe = cdns_gpio_probe,
 	.remove = cdns_gpio_remove,
diff --git a/drivers/gpio/gpio-creg-snps.c b/drivers/gpio/gpio-creg-snps.c
index 1d0827e79703..00a24a32566d 100644
--- a/drivers/gpio/gpio-creg-snps.c
+++ b/drivers/gpio/gpio-creg-snps.c
@@ -182,7 +182,7 @@ static int creg_gpio_probe(struct platform_device *pdev)
 static struct platform_driver creg_gpio_snps_driver = {
 	.driver = {
 		.name = "snps-creg-gpio",
-		.of_match_table = creg_gpio_ids,
+		.of_match_table = of_match_ptr(creg_gpio_ids),
 	},
 	.probe  = creg_gpio_probe,
 };
diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 2a9046c0fb16..6da5db81ddba 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -822,8 +822,8 @@ static struct platform_driver dwapb_gpio_driver = {
 	.driver		= {
 		.name	= DWAPB_DRIVER_NAME,
 		.pm	= &dwapb_gpio_pm_ops,
-		.of_match_table = dwapb_of_match,
-		.acpi_match_table = dwapb_acpi_match,
+		.of_match_table = of_match_ptr(dwapb_of_match),
+		.acpi_match_table = ACPI_PTR(dwapb_acpi_match),
 	},
 	.probe		= dwapb_gpio_probe,
 };
diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index ad61daf6c212..0189d63e4e24 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -680,7 +680,7 @@ static struct platform_driver sprd_eic_driver = {
 	.probe = sprd_eic_probe,
 	.driver = {
 		.name = "sprd-eic",
-		.of_match_table	= sprd_eic_of_match,
+		.of_match_table	= of_match_ptr(sprd_eic_of_match),
 	},
 };
 
diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
index 17a243c528ad..c224f08fc4c2 100644
--- a/drivers/gpio/gpio-em.c
+++ b/drivers/gpio/gpio-em.c
@@ -370,7 +370,7 @@ static struct platform_driver em_gio_device_driver = {
 	.probe		= em_gio_probe,
 	.driver		= {
 		.name	= "em_gio",
-		.of_match_table = em_gio_dt_ids,
+		.of_match_table = of_match_ptr(em_gio_dt_ids),
 	}
 };
 
diff --git a/drivers/gpio/gpio-ge.c b/drivers/gpio/gpio-ge.c
index 636952769bc8..4c07bb9553e1 100644
--- a/drivers/gpio/gpio-ge.c
+++ b/drivers/gpio/gpio-ge.c
@@ -99,7 +99,7 @@ static int __init gef_gpio_probe(struct platform_device *pdev)
 static struct platform_driver gef_gpio_driver = {
 	.driver = {
 		.name		= "gef-gpio",
-		.of_match_table	= gef_gpio_ids,
+		.of_match_table	= of_match_ptr(gef_gpio_ids),
 	},
 };
 module_platform_driver_probe(gef_gpio_driver, gef_gpio_probe);
diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
index f954359c9544..7451b9f412bc 100644
--- a/drivers/gpio/gpio-grgpio.c
+++ b/drivers/gpio/gpio-grgpio.c
@@ -467,7 +467,7 @@ MODULE_DEVICE_TABLE(of, grgpio_match);
 static struct platform_driver grgpio_driver = {
 	.driver = {
 		.name = "grgpio",
-		.of_match_table = grgpio_match,
+		.of_match_table = of_match_ptr(grgpio_match),
 	},
 	.probe = grgpio_probe,
 	.remove = grgpio_remove,
diff --git a/drivers/gpio/gpio-gw-pld.c b/drivers/gpio/gpio-gw-pld.c
index 242112ff60ee..cd3fb19dff49 100644
--- a/drivers/gpio/gpio-gw-pld.c
+++ b/drivers/gpio/gpio-gw-pld.c
@@ -126,7 +126,7 @@ MODULE_DEVICE_TABLE(of, gw_pld_dt_ids);
 static struct i2c_driver gw_pld_driver = {
 	.driver = {
 		.name = "gw_pld",
-		.of_match_table = gw_pld_dt_ids,
+		.of_match_table = of_match_ptr(gw_pld_dt_ids),
 	},
 	.probe = gw_pld_probe,
 	.id_table = gw_pld_id,
diff --git a/drivers/gpio/gpio-hlwd.c b/drivers/gpio/gpio-hlwd.c
index 4a17599f6d44..251b6cb4b477 100644
--- a/drivers/gpio/gpio-hlwd.c
+++ b/drivers/gpio/gpio-hlwd.c
@@ -294,7 +294,7 @@ MODULE_DEVICE_TABLE(of, hlwd_gpio_match);
 static struct platform_driver hlwd_gpio_driver = {
 	.driver	= {
 		.name		= "gpio-hlwd",
-		.of_match_table	= hlwd_gpio_match,
+		.of_match_table	= of_match_ptr(hlwd_gpio_match),
 	},
 	.probe	= hlwd_gpio_probe,
 };
diff --git a/drivers/gpio/gpio-logicvc.c b/drivers/gpio/gpio-logicvc.c
index 015632cf159f..b87d371f0a2e 100644
--- a/drivers/gpio/gpio-logicvc.c
+++ b/drivers/gpio/gpio-logicvc.c
@@ -158,7 +158,7 @@ MODULE_DEVICE_TABLE(of, logicivc_gpio_of_table);
 static struct platform_driver logicvc_gpio_driver = {
 	.driver	= {
 		.name		= "gpio-logicvc",
-		.of_match_table	= logicivc_gpio_of_table,
+		.of_match_table	= of_match_ptr(logicivc_gpio_of_table),
 	},
 	.probe	= logicvc_gpio_probe,
 };
diff --git a/drivers/gpio/gpio-lp3943.c b/drivers/gpio/gpio-lp3943.c
index 8a30fb185aab..cd44bc6f9eb3 100644
--- a/drivers/gpio/gpio-lp3943.c
+++ b/drivers/gpio/gpio-lp3943.c
@@ -215,7 +215,7 @@ static struct platform_driver lp3943_gpio_driver = {
 	.probe = lp3943_gpio_probe,
 	.driver = {
 		.name = "lp3943-gpio",
-		.of_match_table = lp3943_gpio_of_match,
+		.of_match_table = of_match_ptr(lp3943_gpio_of_match),
 	},
 };
 module_platform_driver(lp3943_gpio_driver);
diff --git a/drivers/gpio/gpio-lpc18xx.c b/drivers/gpio/gpio-lpc18xx.c
index d711ae06747e..3e86bb783232 100644
--- a/drivers/gpio/gpio-lpc18xx.c
+++ b/drivers/gpio/gpio-lpc18xx.c
@@ -405,7 +405,7 @@ static struct platform_driver lpc18xx_gpio_driver = {
 	.remove	= lpc18xx_gpio_remove,
 	.driver	= {
 		.name		= "lpc18xx-gpio",
-		.of_match_table	= lpc18xx_gpio_match,
+		.of_match_table	= of_match_ptr(lpc18xx_gpio_match),
 	},
 };
 module_platform_driver(lpc18xx_gpio_driver);
diff --git a/drivers/gpio/gpio-mb86s7x.c b/drivers/gpio/gpio-mb86s7x.c
index 37c5363e391e..83a599360df7 100644
--- a/drivers/gpio/gpio-mb86s7x.c
+++ b/drivers/gpio/gpio-mb86s7x.c
@@ -233,7 +233,7 @@ MODULE_DEVICE_TABLE(acpi, mb86s70_gpio_acpi_ids);
 static struct platform_driver mb86s70_gpio_driver = {
 	.driver = {
 		.name = "mb86s70-gpio",
-		.of_match_table = mb86s70_gpio_dt_ids,
+		.of_match_table = of_match_ptr(mb86s70_gpio_dt_ids),
 		.acpi_match_table = ACPI_PTR(mb86s70_gpio_acpi_ids),
 	},
 	.probe = mb86s70_gpio_probe,
diff --git a/drivers/gpio/gpio-mm-lantiq.c b/drivers/gpio/gpio-mm-lantiq.c
index 538e31fe8903..070d11a8f7cb 100644
--- a/drivers/gpio/gpio-mm-lantiq.c
+++ b/drivers/gpio/gpio-mm-lantiq.c
@@ -141,7 +141,7 @@ static struct platform_driver ltq_mm_driver = {
 	.remove = ltq_mm_remove,
 	.driver = {
 		.name = "gpio-mm-ltq",
-		.of_match_table = ltq_mm_match,
+		.of_match_table = of_match_ptr(ltq_mm_match),
 	},
 };
 
diff --git a/drivers/gpio/gpio-moxtet.c b/drivers/gpio/gpio-moxtet.c
index 8299909318f4..48819b5d46a5 100644
--- a/drivers/gpio/gpio-moxtet.c
+++ b/drivers/gpio/gpio-moxtet.c
@@ -167,7 +167,7 @@ static const enum turris_mox_module_id moxtet_gpio_module_table[] = {
 static struct moxtet_driver moxtet_gpio_driver = {
 	.driver = {
 		.name		= "moxtet-gpio",
-		.of_match_table	= moxtet_gpio_dt_ids,
+		.of_match_table	= of_match_ptr(moxtet_gpio_dt_ids),
 		.probe		= moxtet_gpio_probe,
 	},
 	.id_table = moxtet_gpio_module_table,
diff --git a/drivers/gpio/gpio-mpc5200.c b/drivers/gpio/gpio-mpc5200.c
index 000494e0c533..89754d8606e9 100644
--- a/drivers/gpio/gpio-mpc5200.c
+++ b/drivers/gpio/gpio-mpc5200.c
@@ -182,7 +182,7 @@ static const struct of_device_id mpc52xx_wkup_gpiochip_match[] = {
 static struct platform_driver mpc52xx_wkup_gpiochip_driver = {
 	.driver = {
 		.name = "mpc5200-gpio-wkup",
-		.of_match_table = mpc52xx_wkup_gpiochip_match,
+		.of_match_table = of_match_ptr(mpc52xx_wkup_gpiochip_match),
 	},
 	.probe = mpc52xx_wkup_gpiochip_probe,
 	.remove = mpc52xx_gpiochip_remove,
@@ -335,7 +335,7 @@ static const struct of_device_id mpc52xx_simple_gpiochip_match[] = {
 static struct platform_driver mpc52xx_simple_gpiochip_driver = {
 	.driver = {
 		.name = "mpc5200-gpio",
-		.of_match_table = mpc52xx_simple_gpiochip_match,
+		.of_match_table = of_match_ptr(mpc52xx_simple_gpiochip_match),
 	},
 	.probe = mpc52xx_simple_gpiochip_probe,
 	.remove = mpc52xx_gpiochip_remove,
diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index 6dfca83bcd90..fe4c5451acbf 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -430,7 +430,7 @@ static struct platform_driver mpc8xxx_plat_driver = {
 	.remove		= mpc8xxx_remove,
 	.driver		= {
 		.name = "gpio-mpc8xxx",
-		.of_match_table	= mpc8xxx_gpio_ids,
+		.of_match_table	= of_match_ptr(mpc8xxx_gpio_ids),
 	},
 };
 
diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index 82fb20dca53a..d247fa58379c 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -330,7 +330,7 @@ static struct platform_driver mediatek_gpio_driver = {
 	.probe = mediatek_gpio_probe,
 	.driver = {
 		.name = "mt7621_gpio",
-		.of_match_table = mediatek_gpio_match,
+		.of_match_table = of_match_ptr(mediatek_gpio_match),
 	},
 };
 
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 433e2c3f3fd5..f436812eb9f5 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -1269,7 +1269,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 static struct platform_driver mvebu_gpio_driver = {
 	.driver		= {
 		.name		= "mvebu-gpio",
-		.of_match_table = mvebu_gpio_of_match,
+		.of_match_table = of_match_ptr(mvebu_gpio_of_match),
 	},
 	.probe		= mvebu_gpio_probe,
 	.suspend        = mvebu_gpio_suspend,
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 643f4c557ac2..c3e8a77766c8 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -592,7 +592,7 @@ static struct syscore_ops mxc_gpio_syscore_ops = {
 static struct platform_driver mxc_gpio_driver = {
 	.driver		= {
 		.name	= "gpio-mxc",
-		.of_match_table = mxc_gpio_dt_ids,
+		.of_match_table = of_match_ptr(mxc_gpio_dt_ids),
 		.suppress_bind_attrs = true,
 	},
 	.probe		= mxc_gpio_probe,
diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index c4a314c68555..820f9e28178e 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -366,7 +366,7 @@ static int mxs_gpio_probe(struct platform_device *pdev)
 static struct platform_driver mxs_gpio_driver = {
 	.driver		= {
 		.name	= "gpio-mxs",
-		.of_match_table = mxs_gpio_dt_ids,
+		.of_match_table = of_match_ptr(mxs_gpio_dt_ids),
 		.suppress_bind_attrs = true,
 	},
 	.probe		= mxs_gpio_probe,
diff --git a/drivers/gpio/gpio-octeon.c b/drivers/gpio/gpio-octeon.c
index afb0e8a791e5..cc8bd2055e79 100644
--- a/drivers/gpio/gpio-octeon.c
+++ b/drivers/gpio/gpio-octeon.c
@@ -125,7 +125,7 @@ MODULE_DEVICE_TABLE(of, octeon_gpio_match);
 static struct platform_driver octeon_gpio_driver = {
 	.driver = {
 		.name		= "octeon_gpio",
-		.of_match_table = octeon_gpio_match,
+		.of_match_table = of_match_ptr(octeon_gpio_match),
 	},
 	.probe		= octeon_gpio_probe,
 };
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index f7ceb2b11afc..6a6d4b52bfb5 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1559,7 +1559,7 @@ static struct platform_driver omap_gpio_driver = {
 	.driver		= {
 		.name	= "omap_gpio",
 		.pm	= &gpio_pm_ops,
-		.of_match_table = omap_gpio_match,
+		.of_match_table = of_match_ptr(omap_gpio_match),
 	},
 };
 
diff --git a/drivers/gpio/gpio-palmas.c b/drivers/gpio/gpio-palmas.c
index e8e9029ba5bd..2bff9a01e9ea 100644
--- a/drivers/gpio/gpio-palmas.c
+++ b/drivers/gpio/gpio-palmas.c
@@ -192,7 +192,7 @@ static int palmas_gpio_probe(struct platform_device *pdev)
 
 static struct platform_driver palmas_gpio_driver = {
 	.driver.name	= "palmas-gpio",
-	.driver.of_match_table = of_palmas_gpio_match,
+	.driver.of_match_table = of_match_ptr(of_palmas_gpio_match),
 	.probe		= palmas_gpio_probe,
 };
 
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 825b362eb4b7..de476d0f395d 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1284,8 +1284,8 @@ static struct i2c_driver pca953x_driver = {
 	.driver = {
 		.name	= "pca953x",
 		.pm	= &pca953x_pm_ops,
-		.of_match_table = pca953x_dt_ids,
-		.acpi_match_table = pca953x_acpi_ids,
+		.of_match_table = of_match_ptr(pca953x_dt_ids),
+		.acpi_match_table = ACPI_PTR(pca953x_acpi_ids),
 	},
 	.probe		= pca953x_probe,
 	.remove		= pca953x_remove,
diff --git a/drivers/gpio/gpio-pca9570.c b/drivers/gpio/gpio-pca9570.c
index cb2b2f735c15..58f3d8ffcc8a 100644
--- a/drivers/gpio/gpio-pca9570.c
+++ b/drivers/gpio/gpio-pca9570.c
@@ -134,7 +134,7 @@ MODULE_DEVICE_TABLE(of, pca9570_of_match_table);
 static struct i2c_driver pca9570_driver = {
 	.driver = {
 		.name = "pca9570",
-		.of_match_table = pca9570_of_match_table,
+		.of_match_table = of_match_ptr(pca9570_of_match_table),
 	},
 	.probe_new = pca9570_probe,
 	.id_table = pca9570_id_table,
diff --git a/drivers/gpio/gpio-pisosr.c b/drivers/gpio/gpio-pisosr.c
index 8e04054cf07e..5d452bd489d7 100644
--- a/drivers/gpio/gpio-pisosr.c
+++ b/drivers/gpio/gpio-pisosr.c
@@ -189,7 +189,7 @@ MODULE_DEVICE_TABLE(of, pisosr_gpio_of_match_table);
 static struct spi_driver pisosr_gpio_driver = {
 	.driver = {
 		.name = "pisosr-gpio",
-		.of_match_table = pisosr_gpio_of_match_table,
+		.of_match_table = of_match_ptr(pisosr_gpio_of_match_table),
 	},
 	.probe = pisosr_gpio_probe,
 	.remove = pisosr_gpio_remove,
diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index 938285190566..8306d7263b46 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -371,7 +371,7 @@ static struct platform_driver sprd_pmic_eic_driver = {
 	.probe = sprd_pmic_eic_probe,
 	.driver = {
 		.name = "sprd-pmic-eic",
-		.of_match_table	= sprd_pmic_eic_of_match,
+		.of_match_table	= of_match_ptr(sprd_pmic_eic_of_match),
 	},
 };
 
diff --git a/drivers/gpio/gpio-rda.c b/drivers/gpio/gpio-rda.c
index 28dcbb58b76b..81a0f2fa79e6 100644
--- a/drivers/gpio/gpio-rda.c
+++ b/drivers/gpio/gpio-rda.c
@@ -283,7 +283,7 @@ static struct platform_driver rda_gpio_driver = {
 	.probe = rda_gpio_probe,
 	.driver = {
 		.name = "rda-gpio",
-		.of_match_table	= rda_gpio_of_match,
+		.of_match_table	= of_match_ptr(rda_gpio_of_match),
 	},
 };
 
diff --git a/drivers/gpio/gpio-sl28cpld.c b/drivers/gpio/gpio-sl28cpld.c
index 889b8f5622c2..e46583cc1ece 100644
--- a/drivers/gpio/gpio-sl28cpld.c
+++ b/drivers/gpio/gpio-sl28cpld.c
@@ -151,7 +151,7 @@ static struct platform_driver sl28cpld_gpio_driver = {
 	.probe = sl28cpld_gpio_probe,
 	.driver = {
 		.name = "sl28cpld-gpio",
-		.of_match_table = sl28cpld_gpio_of_match,
+		.of_match_table = of_match_ptr(sl28cpld_gpio_of_match),
 	},
 };
 module_platform_driver(sl28cpld_gpio_driver);
diff --git a/drivers/gpio/gpio-spear-spics.c b/drivers/gpio/gpio-spear-spics.c
index 6eca531b7d96..a074598d538a 100644
--- a/drivers/gpio/gpio-spear-spics.c
+++ b/drivers/gpio/gpio-spear-spics.c
@@ -186,7 +186,7 @@ static struct platform_driver spics_gpio_driver = {
 	.probe = spics_gpio_probe,
 	.driver = {
 		.name = "spear-spics-gpio",
-		.of_match_table = spics_gpio_of_match,
+		.of_match_table = of_match_ptr(spics_gpio_of_match),
 	},
 };
 
diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
index 36ea8a3bd451..f2d6b9fe2780 100644
--- a/drivers/gpio/gpio-sprd.c
+++ b/drivers/gpio/gpio-sprd.c
@@ -279,7 +279,7 @@ static struct platform_driver sprd_gpio_driver = {
 	.probe = sprd_gpio_probe,
 	.driver = {
 		.name = "sprd-gpio",
-		.of_match_table	= sprd_gpio_of_match,
+		.of_match_table	= of_match_ptr(sprd_gpio_of_match),
 	},
 };
 
diff --git a/drivers/gpio/gpio-stp-xway.c b/drivers/gpio/gpio-stp-xway.c
index 0ce1543426a4..1130934066c8 100644
--- a/drivers/gpio/gpio-stp-xway.c
+++ b/drivers/gpio/gpio-stp-xway.c
@@ -328,7 +328,7 @@ static struct platform_driver xway_stp_driver = {
 	.probe = xway_stp_probe,
 	.driver = {
 		.name = "gpio-stp-xway",
-		.of_match_table = xway_stp_match,
+		.of_match_table = of_match_ptr(xway_stp_match),
 	},
 };
 
diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index fdd3d497b535..cbf1069e5e95 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -268,7 +268,7 @@ static int syscon_gpio_probe(struct platform_device *pdev)
 static struct platform_driver syscon_gpio_driver = {
 	.driver	= {
 		.name		= "gpio-syscon",
-		.of_match_table	= syscon_gpio_ids,
+		.of_match_table	= of_match_ptr(syscon_gpio_ids),
 	},
 	.probe	= syscon_gpio_probe,
 };
diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index 866201cf5f65..6d7990e97931 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -236,7 +236,7 @@ static struct platform_driver tb10x_gpio_driver = {
 	.remove		= tb10x_gpio_remove,
 	.driver = {
 		.name	= "tb10x-gpio",
-		.of_match_table = tb10x_gpio_dt_ids,
+		.of_match_table = of_match_ptr(tb10x_gpio_dt_ids),
 	}
 };
 
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 86568154cdb3..932a7dfa246d 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -708,7 +708,7 @@ static struct platform_driver tegra_gpio_driver = {
 	.driver		= {
 		.name	= "tegra-gpio",
 		.pm	= &tegra_gpio_pm_ops,
-		.of_match_table = tegra_gpio_of_match,
+		.of_match_table = of_match_ptr(tegra_gpio_of_match),
 	},
 	.probe		= tegra_gpio_probe,
 };
diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 9500074b1f1b..2fc04c1950a1 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -910,7 +910,7 @@ MODULE_DEVICE_TABLE(of, tegra186_gpio_of_match);
 static struct platform_driver tegra186_gpio_driver = {
 	.driver = {
 		.name = "tegra186-gpio",
-		.of_match_table = tegra186_gpio_of_match,
+		.of_match_table = of_match_ptr(tegra186_gpio_of_match),
 	},
 	.probe = tegra186_gpio_probe,
 	.remove = tegra186_gpio_remove,
diff --git a/drivers/gpio/gpio-tpic2810.c b/drivers/gpio/gpio-tpic2810.c
index 99d5a84a9129..6ef43468c5b9 100644
--- a/drivers/gpio/gpio-tpic2810.c
+++ b/drivers/gpio/gpio-tpic2810.c
@@ -152,7 +152,7 @@ MODULE_DEVICE_TABLE(i2c, tpic2810_id_table);
 static struct i2c_driver tpic2810_driver = {
 	.driver = {
 		.name = "tpic2810",
-		.of_match_table = tpic2810_of_match_table,
+		.of_match_table = of_match_ptr(tpic2810_of_match_table),
 	},
 	.probe = tpic2810_probe,
 	.remove = tpic2810_remove,
diff --git a/drivers/gpio/gpio-ts4800.c b/drivers/gpio/gpio-ts4800.c
index 8c0d82d926dd..e1bffa01b338 100644
--- a/drivers/gpio/gpio-ts4800.c
+++ b/drivers/gpio/gpio-ts4800.c
@@ -69,7 +69,7 @@ MODULE_DEVICE_TABLE(of, ts4800_gpio_of_match);
 static struct platform_driver ts4800_gpio_driver = {
 	.driver = {
 		   .name = "ts4800-gpio",
-		   .of_match_table = ts4800_gpio_of_match,
+		   .of_match_table = of_match_ptr(ts4800_gpio_of_match),
 		   },
 	.probe = ts4800_gpio_probe,
 };
diff --git a/drivers/gpio/gpio-ts4900.c b/drivers/gpio/gpio-ts4900.c
index d885032cf814..53d02d94b3a3 100644
--- a/drivers/gpio/gpio-ts4900.c
+++ b/drivers/gpio/gpio-ts4900.c
@@ -176,7 +176,7 @@ MODULE_DEVICE_TABLE(i2c, ts4900_gpio_id_table);
 static struct i2c_driver ts4900_gpio_driver = {
 	.driver = {
 		.name = "ts4900-gpio",
-		.of_match_table = ts4900_gpio_of_match_table,
+		.of_match_table = of_match_ptr(ts4900_gpio_of_match_table),
 	},
 	.probe = ts4900_gpio_probe,
 	.id_table = ts4900_gpio_id_table,
diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index de249726230e..9816d2e31984 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -628,7 +628,7 @@ MODULE_ALIAS("platform:twl4030_gpio");
 static struct platform_driver gpio_twl4030_driver = {
 	.driver = {
 		.name	= "twl4030_gpio",
-		.of_match_table = twl_gpio_match,
+		.of_match_table = of_match_ptr(twl_gpio_match),
 	},
 	.probe		= gpio_twl4030_probe,
 	.remove		= gpio_twl4030_remove,
diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
index f99f3c10bed0..a8dbeec506f2 100644
--- a/drivers/gpio/gpio-uniphier.c
+++ b/drivers/gpio/gpio-uniphier.c
@@ -484,7 +484,7 @@ static struct platform_driver uniphier_gpio_driver = {
 	.remove = uniphier_gpio_remove,
 	.driver = {
 		.name = "uniphier-gpio",
-		.of_match_table = uniphier_gpio_match,
+		.of_match_table = of_match_ptr(uniphier_gpio_match),
 		.pm = &uniphier_gpio_pm_ops,
 	},
 };
diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 58776f2d69ff..adbec3ad965a 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -345,7 +345,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 static struct platform_driver vf610_gpio_driver = {
 	.driver		= {
 		.name	= "gpio-vf610",
-		.of_match_table = vf610_gpio_dt_ids,
+		.of_match_table = of_match_ptr(vf610_gpio_dt_ids),
 	},
 	.probe		= vf610_gpio_probe,
 };
diff --git a/drivers/gpio/gpio-wcd934x.c b/drivers/gpio/gpio-wcd934x.c
index 1cbce5990855..9ac77d967636 100644
--- a/drivers/gpio/gpio-wcd934x.c
+++ b/drivers/gpio/gpio-wcd934x.c
@@ -114,7 +114,7 @@ MODULE_DEVICE_TABLE(of, wcd_gpio_of_match);
 static struct platform_driver wcd_gpio_driver = {
 	.driver = {
 		   .name = "wcd934x-gpio",
-		   .of_match_table = wcd_gpio_of_match,
+		   .of_match_table = of_match_ptr(wcd_gpio_of_match),
 	},
 	.probe = wcd_gpio_probe,
 };
diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
index a809609ee957..28fd4f015b2c 100644
--- a/drivers/gpio/gpio-xgene-sb.c
+++ b/drivers/gpio/gpio-xgene-sb.c
@@ -324,7 +324,7 @@ MODULE_DEVICE_TABLE(acpi, xgene_gpio_sb_acpi_match);
 static struct platform_driver xgene_gpio_sb_driver = {
 	.driver = {
 		   .name = "xgene-gpio-sb",
-		   .of_match_table = xgene_gpio_sb_of_match,
+		   .of_match_table = of_match_ptr(xgene_gpio_sb_of_match),
 		   .acpi_match_table = ACPI_PTR(xgene_gpio_sb_acpi_match),
 		   },
 	.probe = xgene_gpio_sb_probe,
diff --git a/drivers/gpio/gpio-xgene.c b/drivers/gpio/gpio-xgene.c
index 532b0df8a1f2..f7b2a2a9e435 100644
--- a/drivers/gpio/gpio-xgene.c
+++ b/drivers/gpio/gpio-xgene.c
@@ -209,7 +209,7 @@ static const struct acpi_device_id xgene_gpio_acpi_match[] = {
 static struct platform_driver xgene_gpio_driver = {
 	.driver = {
 		.name = "xgene-gpio",
-		.of_match_table = xgene_gpio_of_match,
+		.of_match_table = of_match_ptr(xgene_gpio_of_match),
 		.acpi_match_table = ACPI_PTR(xgene_gpio_acpi_match),
 		.pm     = &xgene_gpio_pm,
 	},
diff --git a/drivers/gpio/gpio-xgs-iproc.c b/drivers/gpio/gpio-xgs-iproc.c
index ad5489a65d54..fce7ccc8bd7c 100644
--- a/drivers/gpio/gpio-xgs-iproc.c
+++ b/drivers/gpio/gpio-xgs-iproc.c
@@ -307,7 +307,7 @@ MODULE_DEVICE_TABLE(of, bcm_iproc_gpio_of_match);
 static struct platform_driver bcm_iproc_gpio_driver = {
 	.driver = {
 		.name = "iproc-xgs-gpio",
-		.of_match_table = bcm_iproc_gpio_of_match,
+		.of_match_table = of_match_ptr(bcm_iproc_gpio_of_match),
 	},
 	.probe = iproc_gpio_probe,
 	.remove = iproc_gpio_remove,
diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index 67f9f82e0db0..3a82409d950e 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -356,7 +356,7 @@ static struct platform_driver xgpio_plat_driver = {
 	.probe		= xgpio_probe,
 	.driver		= {
 			.name = "gpio-xilinx",
-			.of_match_table	= xgpio_of_match,
+			.of_match_table	= of_match_ptr(xgpio_of_match),
 	},
 };
 
diff --git a/drivers/gpio/gpio-xlp.c b/drivers/gpio/gpio-xlp.c
index d7b16bb9e4e4..fdf9b2ed7cae 100644
--- a/drivers/gpio/gpio-xlp.c
+++ b/drivers/gpio/gpio-xlp.c
@@ -431,7 +431,7 @@ MODULE_DEVICE_TABLE(acpi, xlp_gpio_acpi_match);
 static struct platform_driver xlp_gpio_driver = {
 	.driver		= {
 		.name	= "xlp-gpio",
-		.of_match_table = xlp_gpio_of_ids,
+		.of_match_table = of_match_ptr(xlp_gpio_of_ids),
 		.acpi_match_table = ACPI_PTR(xlp_gpio_acpi_match),
 	},
 	.probe		= xlp_gpio_probe,
diff --git a/drivers/gpio/gpio-zevio.c b/drivers/gpio/gpio-zevio.c
index f6f8a541348f..bdfcbf9947ac 100644
--- a/drivers/gpio/gpio-zevio.c
+++ b/drivers/gpio/gpio-zevio.c
@@ -208,7 +208,7 @@ static const struct of_device_id zevio_gpio_of_match[] = {
 static struct platform_driver zevio_gpio_driver = {
 	.driver		= {
 		.name	= "gpio-zevio",
-		.of_match_table = zevio_gpio_of_match,
+		.of_match_table = of_match_ptr(zevio_gpio_of_match),
 		.suppress_bind_attrs = true,
 	},
 	.probe		= zevio_gpio_probe,
diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 0b5a17ab996f..6a68fab20090 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -1014,7 +1014,7 @@ static struct platform_driver zynq_gpio_driver = {
 	.driver	= {
 		.name = DRIVER_NAME,
 		.pm = &zynq_gpio_dev_pm_ops,
-		.of_match_table = zynq_gpio_of_match,
+		.of_match_table = of_match_ptr(zynq_gpio_of_match),
 	},
 	.probe = zynq_gpio_probe,
 	.remove = zynq_gpio_remove,
-- 
2.11.0

