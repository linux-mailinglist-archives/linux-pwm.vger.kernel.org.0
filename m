Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89AD79BE99
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 17:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfHXPhq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 11:37:46 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:45490 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfHXPhq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Aug 2019 11:37:46 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 325BB77EAEE; Sat, 24 Aug 2019 17:37:42 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Patrick Havelange <patrick.havelange@essensium.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 6/6] pwm: ensure pwm_apply_state() doesn't modify the state argument
Date:   Sat, 24 Aug 2019 17:37:07 +0200
Message-Id: <20190824153707.13746-7-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190824153707.13746-1-uwe@kleine-koenig.org>
References: <20190824153707.13746-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

It is surprising for a PWM consumer when the variable holding the
requested state is modified by pwm_apply_state(). Consider for example a
driver doing:

        #define PERIOD 5000000
        #define DUTY_LITTLE 10
        ...
        struct pwm_state state = {
                .period = PERIOD,
                .duty_cycle = DUTY_LITTLE,
                .polarity = PWM_POLARITY_NORMAL,
                .enabled = true,
        };

        pwm_apply_state(mypwm, &state);
        ...
        state.duty_cycle = PERIOD / 2;
        pwm_apply_state(mypwm, &state);

For sure the second call to pwm_apply_state() should still have
state.period = PERIOD and not something the hardware driver chose for a
reason that doesn't necessarily apply to the second call.

So declare the state argument as a pointer to a const type and adapt all
drivers' .apply callbacks.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c            | 6 ++----
 drivers/pwm/pwm-atmel-hlcdc.c | 2 +-
 drivers/pwm/pwm-atmel.c       | 2 +-
 drivers/pwm/pwm-bcm-iproc.c   | 2 +-
 drivers/pwm/pwm-cros-ec.c     | 2 +-
 drivers/pwm/pwm-fsl-ftm.c     | 4 ++--
 drivers/pwm/pwm-hibvt.c       | 2 +-
 drivers/pwm/pwm-imx-tpm.c     | 4 ++--
 drivers/pwm/pwm-imx27.c       | 2 +-
 drivers/pwm/pwm-jz4740.c      | 2 +-
 drivers/pwm/pwm-lpss.c        | 2 +-
 drivers/pwm/pwm-meson.c       | 4 ++--
 drivers/pwm/pwm-rcar.c        | 2 +-
 drivers/pwm/pwm-rockchip.c    | 4 ++--
 drivers/pwm/pwm-sifive.c      | 2 +-
 drivers/pwm/pwm-stm32-lp.c    | 2 +-
 drivers/pwm/pwm-stm32.c       | 4 ++--
 drivers/pwm/pwm-sun4i.c       | 4 ++--
 drivers/pwm/pwm-zx.c          | 2 +-
 include/linux/pwm.h           | 4 ++--
 20 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 92333b89bf02..95f0d0054910 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -448,11 +448,9 @@ EXPORT_SYMBOL_GPL(pwm_free);
 /**
  * pwm_apply_state() - atomically apply a new state to a PWM device
  * @pwm: PWM device
- * @state: new state to apply. This can be adjusted by the PWM driver
- *	   if the requested config is not achievable, for example,
- *	   ->duty_cycle and ->period might be approximated.
+ * @state: new state to apply.
  */
-int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
+int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 {
 	int err;
 	struct pwm_chip *chip;
diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index d13a83f430ac..dcbc0489dfd4 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -39,7 +39,7 @@ static inline struct atmel_hlcdc_pwm *to_atmel_hlcdc_pwm(struct pwm_chip *chip)
 }
 
 static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
-				 struct pwm_state *state)
+				 const struct pwm_state *state)
 {
 	struct atmel_hlcdc_pwm *chip = to_atmel_hlcdc_pwm(c);
 	struct atmel_hlcdc *hlcdc = chip->hlcdc;
diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index e5e1eaf372fa..53bc7b9b3581 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -209,7 +209,7 @@ static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm,
 }
 
 static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			   struct pwm_state *state)
+			   const struct pwm_state *state)
 {
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 	struct pwm_state cstate;
diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index d961a8207b1c..56c38cfae92c 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -115,7 +115,7 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 }
 
 static int iproc_pwmc_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			    struct pwm_state *state)
+			    const struct pwm_state *state)
 {
 	unsigned long prescale = IPROC_PWM_PRESCALE_MIN;
 	struct iproc_pwmc *ip = to_iproc_pwmc(chip);
diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 98f6ac6cf6ab..db5faa79c33f 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -93,7 +93,7 @@ static int cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index)
 }
 
 static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			     struct pwm_state *state)
+			     const struct pwm_state *state)
 {
 	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
 	int duty_cycle;
diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 3c9738617ceb..59272a920479 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -227,7 +227,7 @@ static bool fsl_pwm_is_other_pwm_enabled(struct fsl_pwm_chip *fpc,
 
 static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
 				struct pwm_device *pwm,
-				struct pwm_state *newstate)
+				const struct pwm_state *newstate)
 {
 	unsigned int duty;
 	u32 reg_polarity;
@@ -298,7 +298,7 @@ static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
 }
 
 static int fsl_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			 struct pwm_state *newstate)
+			 const struct pwm_state *newstate)
 {
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 	struct pwm_state *oldstate = &pwm->state;
diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index 753bd58111e4..ad205fdad372 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -149,7 +149,7 @@ static void hibvt_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 }
 
 static int hibvt_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-				struct pwm_state *state)
+			   const struct pwm_state *state)
 {
 	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
 
diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index e8385c1cf342..9145f6160649 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -89,7 +89,7 @@ to_imx_tpm_pwm_chip(struct pwm_chip *chip)
 static int pwm_imx_tpm_round_state(struct pwm_chip *chip,
 				   struct imx_tpm_pwm_param *p,
 				   struct pwm_state *real_state,
-				   struct pwm_state *state)
+				   const struct pwm_state *state)
 {
 	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
 	u32 rate, prescale, period_count, clock_unit;
@@ -289,7 +289,7 @@ static int pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
 
 static int pwm_imx_tpm_apply(struct pwm_chip *chip,
 			     struct pwm_device *pwm,
-			     struct pwm_state *state)
+			     const struct pwm_state *state)
 {
 	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
 	struct imx_tpm_pwm_param param;
diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 434a351fb626..aa456de2f98d 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -205,7 +205,7 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 }
 
 static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			   struct pwm_state *state)
+			   const struct pwm_state *state)
 {
 	unsigned long period_cycles, duty_cycles, prescale;
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index f901e8a0d33d..f57e60da5c61 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -83,7 +83,7 @@ static void jz4740_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 }
 
 static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			    struct pwm_state *state)
+			    const struct pwm_state *state)
 {
 	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
 	unsigned long long tmp;
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 4098a4601691..75bbfe5f3bc2 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -122,7 +122,7 @@ static inline void pwm_lpss_cond_enable(struct pwm_device *pwm, bool cond)
 }
 
 static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			  struct pwm_state *state)
+			  const struct pwm_state *state)
 {
 	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
 	int ret;
diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 3cbff5cbb789..6245bbdb6e6c 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -159,7 +159,7 @@ static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 }
 
 static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
-			  struct pwm_state *state)
+			  const struct pwm_state *state)
 {
 	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
 	unsigned int duty, period, pre_div, cnt, duty_cnt;
@@ -265,7 +265,7 @@ static void meson_pwm_disable(struct meson_pwm *meson, struct pwm_device *pwm)
 }
 
 static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			   struct pwm_state *state)
+			   const struct pwm_state *state)
 {
 	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
 	struct meson_pwm *meson = to_meson_pwm(chip);
diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 5b2b8ecc354c..a77fbf29114e 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -158,7 +158,7 @@ static void rcar_pwm_disable(struct rcar_pwm_chip *rp)
 }
 
 static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			  struct pwm_state *state)
+			  const struct pwm_state *state)
 {
 	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
 	struct pwm_state cur_state;
diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index cc502c8d7e9c..45330d7b0f33 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -99,7 +99,7 @@ static void rockchip_pwm_get_state(struct pwm_chip *chip,
 }
 
 static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			       struct pwm_state *state)
+			       const struct pwm_state *state)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
 	unsigned long period, duty;
@@ -183,7 +183,7 @@ static int rockchip_pwm_enable(struct pwm_chip *chip,
 }
 
 static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			      struct pwm_state *state)
+			      const struct pwm_state *state)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
 	struct pwm_state curstate;
diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index a7c107f19e66..6ae580ef5c6e 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -147,7 +147,7 @@ static int pwm_sifive_enable(struct pwm_chip *chip, bool enable)
 }
 
 static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			    struct pwm_state *state)
+			    const struct pwm_state *state)
 {
 	struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
 	struct pwm_state cur_state;
diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 2211a642066d..21cb260dc2c0 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -32,7 +32,7 @@ static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
 #define STM32_LPTIM_MAX_PRESCALER	128
 
 static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			      struct pwm_state *state)
+			      const struct pwm_state *state)
 {
 	struct stm32_pwm_lp *priv = to_stm32_pwm_lp(chip);
 	unsigned long long prd, div, dty;
diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 740e2dec8313..359b08596d9e 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -440,7 +440,7 @@ static void stm32_pwm_disable(struct stm32_pwm *priv, int ch)
 }
 
 static int stm32_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			   struct pwm_state *state)
+			   const struct pwm_state *state)
 {
 	bool enabled;
 	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
@@ -468,7 +468,7 @@ static int stm32_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 }
 
 static int stm32_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
-				  struct pwm_state *state)
+				  const struct pwm_state *state)
 {
 	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
 	int ret;
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 39007a7c0d83..6f5840a1a82d 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -145,7 +145,7 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
 }
 
 static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
-			       struct pwm_state *state,
+			       const struct pwm_state *state,
 			       u32 *dty, u32 *prd, unsigned int *prsclr)
 {
 	u64 clk_rate, div = 0;
@@ -196,7 +196,7 @@ static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
 }
 
 static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			   struct pwm_state *state)
+			   const struct pwm_state *state)
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
 	struct pwm_state cstate;
diff --git a/drivers/pwm/pwm-zx.c b/drivers/pwm/pwm-zx.c
index e24f4be35316..e2c21cc34a96 100644
--- a/drivers/pwm/pwm-zx.c
+++ b/drivers/pwm/pwm-zx.c
@@ -148,7 +148,7 @@ static int zx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 }
 
 static int zx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			struct pwm_state *state)
+			const struct pwm_state *state)
 {
 	struct zx_pwm_chip *zpc = to_zx_pwm_chip(chip);
 	struct pwm_state cstate;
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 24632a7a7d11..b2c9c460947d 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -262,7 +262,7 @@ struct pwm_ops {
 	int (*capture)(struct pwm_chip *chip, struct pwm_device *pwm,
 		       struct pwm_capture *result, unsigned long timeout);
 	int (*apply)(struct pwm_chip *chip, struct pwm_device *pwm,
-		     struct pwm_state *state);
+		     const struct pwm_state *state);
 	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
 			  struct pwm_state *state);
 	struct module *owner;
@@ -316,7 +316,7 @@ struct pwm_capture {
 /* PWM user APIs */
 struct pwm_device *pwm_request(int pwm_id, const char *label);
 void pwm_free(struct pwm_device *pwm);
-int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state);
+int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state);
 int pwm_adjust_config(struct pwm_device *pwm);
 
 /**
-- 
2.20.1

