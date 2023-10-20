Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CDD7D15AF
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Oct 2023 20:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjJTSW7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Oct 2023 14:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjJTSW6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Oct 2023 14:22:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21E1D63;
        Fri, 20 Oct 2023 11:22:54 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KH9Odv027102;
        Fri, 20 Oct 2023 18:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=j0YEjXXdNcTG2WqUNFONzc8Hqqcjs6fSLgUuP4Y6W3A=;
 b=VBbagcmDtAYBo37Z39uGT1AGeJt5FgPcOfeyhd2lSJPr6zaMPHj057zNYvLgjBySJTj7
 QCxYBBQGpIQ7f2WjyFe5h6wJTS+iN66d8P2iAHb01939J4/jVbcw6fHaqcw7S6PYV+Al
 JVwWH+3bQjn52y5Nra7n2X1JT1pGkvWAI5opcAlaq1pkbMYGLoCBQUuY1/36cyCsrTH/
 PtL0p9YmLzvP4fIHUcDA9QI8+hWbcjJ5DkSl1NtBtVmVg9vNkLvohNN/A/VDBcpR5WP/
 Usx1kv+oyrlChnzmpFG/dc8nEY2FxZubYWpML9DPFVJLgYCPKlsV6cuHzxg0xyrPPQh5 sw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tubxgjs7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 18:22:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39KIMiND017604
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 18:22:45 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 20 Oct 2023 11:22:44 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC:     <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <quic_gurus@quicinc.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        "Anjelique Melendez" <quic_amelende@quicinc.com>
Subject: [PATCH v6 4/7] leds: rgb: leds-qcom-lpg: Add support for PPG through single SDAM
Date:   Fri, 20 Oct 2023 11:22:14 -0700
Message-ID: <20231020182218.22217-5-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020182218.22217-1-quic_amelende@quicinc.com>
References: <20231020182218.22217-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kICHDl9XsmHFRxd7bqmcOafonotkvAjw
X-Proofpoint-ORIG-GUID: kICHDl9XsmHFRxd7bqmcOafonotkvAjw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200154
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

In some PMICs like pmi632, the pattern look up table (LUT) and LPG
configuration is stored in a single SDAM module instead of LUT
peripheral. This feature is called PPG. PPG uses Qualcomm Programmable
Boot Sequencer (PBS) inorder to trigger pattern sequences for PMICs.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 264 ++++++++++++++++++++++++++++---
 1 file changed, 242 insertions(+), 22 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index df469aaa7e6e..0c6d0e593c06 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -8,11 +8,13 @@
 #include <linux/bitfield.h>
 #include <linux/led-class-multicolor.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/soc/qcom/qcom-pbs.h>
 
 #define LPG_SUBTYPE_REG		0x05
 #define  LPG_SUBTYPE_LPG	0x2
@@ -39,6 +41,8 @@
 #define PWM_SEC_ACCESS_REG	0xd0
 #define PWM_DTEST_REG(x)	(0xe2 + (x) - 1)
 
+#define SDAM_REG_PBS_SEQ_EN		0x42
+
 #define TRI_LED_SRC_SEL		0x45
 #define TRI_LED_EN_CTL		0x46
 #define TRI_LED_ATC_CTL		0x47
@@ -48,9 +52,25 @@
 
 #define LPG_RESOLUTION_9BIT	BIT(9)
 #define LPG_RESOLUTION_15BIT	BIT(15)
+#define PPG_MAX_LED_BRIGHTNESS	255
+
 #define LPG_MAX_M		7
 #define LPG_MAX_PREDIV		6
 
+#define DEFAULT_TICK_DURATION_US	7800
+#define RAMP_STEP_DURATION(x)		(((x) * 1000 / DEFAULT_TICK_DURATION_US) & 0xff)
+
+/* LPG common config settings for PPG */
+#define SDAM_REG_RAMP_STEP_DURATION		0x47
+#define SDAM_LPG_SDAM_LUT_PATTERN_OFFSET	0x80
+
+/* LPG per channel config settings for PPG */
+#define SDAM_LUT_EN_OFFSET			0x0
+#define SDAM_PATTERN_CONFIG_OFFSET		0x1
+#define SDAM_END_INDEX_OFFSET			0x3
+#define SDAM_START_INDEX_OFFSET		0x4
+#define SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET	0x6
+
 struct lpg_channel;
 struct lpg_data;
 
@@ -64,6 +84,9 @@ struct lpg_data;
  * @lut_base:	base address of the LUT block (optional)
  * @lut_size:	number of entries in the LUT block
  * @lut_bitmap:	allocation bitmap for LUT entries
+ * @pbs_dev:	PBS device
+ * @lpg_chan_sdam:	LPG SDAM peripheral device
+ * @pbs_en_bitmap:	bitmap for tracking PBS triggers
  * @triled_base: base address of the TRILED block (optional)
  * @triled_src:	power-source for the TRILED
  * @triled_has_atc_ctl:	true if there is TRI_LED_ATC_CTL register
@@ -85,6 +108,10 @@ struct lpg {
 	u32 lut_size;
 	unsigned long *lut_bitmap;
 
+	struct pbs_dev *pbs_dev;
+	struct nvmem_device *lpg_chan_sdam;
+	unsigned long pbs_en_bitmap;
+
 	u32 triled_base;
 	u32 triled_src;
 	bool triled_has_atc_ctl;
@@ -101,6 +128,7 @@ struct lpg {
  * @triled_mask: mask in TRILED to enable this channel
  * @lut_mask:	mask in LUT to start pattern generator for this channel
  * @subtype:	PMIC hardware block subtype
+ * @sdam_offset:	channel offset in LPG SDAM
  * @in_use:	channel is exposed to LED framework
  * @color:	color of the LED attached to this channel
  * @dtest_line:	DTEST line for output, or 0 if disabled
@@ -129,6 +157,7 @@ struct lpg_channel {
 	unsigned int triled_mask;
 	unsigned int lut_mask;
 	unsigned int subtype;
+	u32 sdam_offset;
 
 	bool in_use;
 
@@ -178,10 +207,12 @@ struct lpg_led {
 
 /**
  * struct lpg_channel_data - per channel initialization data
+ * @sdam_offset:	Channel offset in LPG SDAM
  * @base:		base address for PWM channel registers
  * @triled_mask:	bitmask for controlling this channel in TRILED
  */
 struct lpg_channel_data {
+	unsigned int sdam_offset;
 	unsigned int base;
 	u8 triled_mask;
 };
@@ -206,6 +237,52 @@ struct lpg_data {
 	const struct lpg_channel_data *channels;
 };
 
+#define PBS_SW_TRIG_BIT		BIT(0)
+
+static int lpg_clear_pbs_trigger(struct lpg *lpg, unsigned int lut_mask)
+{
+	u8 val = 0;
+	int rc;
+
+	lpg->pbs_en_bitmap &= (~lut_mask);
+	if (!lpg->pbs_en_bitmap) {
+		rc = nvmem_device_write(lpg->lpg_chan_sdam, SDAM_REG_PBS_SEQ_EN, 1, &val);
+		if (rc < 0)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int lpg_set_pbs_trigger(struct lpg *lpg, unsigned int lut_mask)
+{
+	u8 val = PBS_SW_TRIG_BIT;
+	int rc;
+
+	if (!lpg->pbs_en_bitmap) {
+		rc = nvmem_device_write(lpg->lpg_chan_sdam, SDAM_REG_PBS_SEQ_EN, 1, &val);
+		if (rc < 0)
+			return rc;
+
+		rc = qcom_pbs_trigger_event(lpg->pbs_dev, val);
+		if (rc < 0)
+			return rc;
+	}
+	lpg->pbs_en_bitmap |= lut_mask;
+
+	return 0;
+}
+
+static int lpg_sdam_configure_triggers(struct lpg_channel *chan, u8 set_trig)
+{
+	u32 addr = SDAM_LUT_EN_OFFSET + chan->sdam_offset;
+
+	if (!chan->lpg->lpg_chan_sdam)
+		return 0;
+
+	return nvmem_device_write(chan->lpg->lpg_chan_sdam, addr, 1, &set_trig);
+}
+
 static int triled_set(struct lpg *lpg, unsigned int mask, unsigned int enable)
 {
 	/* Skip if we don't have a triled block */
@@ -216,6 +293,40 @@ static int triled_set(struct lpg *lpg, unsigned int mask, unsigned int enable)
 				  mask, enable);
 }
 
+static int lpg_lut_store_sdam(struct lpg *lpg, struct led_pattern *pattern,
+			 size_t len, unsigned int *lo_idx, unsigned int *hi_idx)
+{
+	unsigned int idx;
+	u8 brightness;
+	int i, rc;
+	u16 addr;
+
+	if (len > lpg->lut_size) {
+		dev_err(lpg->dev, "Pattern length (%zu) exceeds maximum pattern length (%d)\n",
+			len, lpg->lut_size);
+		return -EINVAL;
+	}
+
+	idx = bitmap_find_next_zero_area(lpg->lut_bitmap, lpg->lut_size, 0, len, 0);
+	if (idx >= lpg->lut_size)
+		return -ENOSPC;
+
+	for (i = 0; i < len; i++) {
+		brightness = pattern[i].brightness;
+		addr = SDAM_LPG_SDAM_LUT_PATTERN_OFFSET + i + idx;
+		rc = nvmem_device_write(lpg->lpg_chan_sdam, addr, 1, &brightness);
+		if (rc < 0)
+			return rc;
+	}
+
+	bitmap_set(lpg->lut_bitmap, idx, len);
+
+	*lo_idx = idx;
+	*hi_idx = idx + len - 1;
+
+	return 0;
+}
+
 static int lpg_lut_store(struct lpg *lpg, struct led_pattern *pattern,
 			 size_t len, unsigned int *lo_idx, unsigned int *hi_idx)
 {
@@ -256,6 +367,9 @@ static void lpg_lut_free(struct lpg *lpg, unsigned int lo_idx, unsigned int hi_i
 
 static int lpg_lut_sync(struct lpg *lpg, unsigned int mask)
 {
+	if (!lpg->lut_base)
+		return 0;
+
 	return regmap_write(lpg->map, lpg->lut_base + RAMP_CONTROL_REG, mask);
 }
 
@@ -462,6 +576,28 @@ static void lpg_apply_pwm_value(struct lpg_channel *chan)
 #define LPG_PATTERN_CONFIG_PAUSE_HI	BIT(1)
 #define LPG_PATTERN_CONFIG_PAUSE_LO	BIT(0)
 
+static void lpg_sdam_apply_lut_control(struct lpg_channel *chan)
+{
+	struct nvmem_device *lpg_chan_sdam = chan->lpg->lpg_chan_sdam;
+	unsigned int lo_idx = chan->pattern_lo_idx;
+	unsigned int hi_idx = chan->pattern_hi_idx;
+	u8 val = 0, conf = 0;
+
+	if (!chan->ramp_enabled || chan->pattern_lo_idx == chan->pattern_hi_idx)
+		return;
+
+	if (!chan->ramp_oneshot)
+		conf |= LPG_PATTERN_CONFIG_REPEAT;
+
+	nvmem_device_write(lpg_chan_sdam, SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET + chan->sdam_offset, 1, &val);
+	nvmem_device_write(lpg_chan_sdam, SDAM_PATTERN_CONFIG_OFFSET + chan->sdam_offset, 1, &conf);
+	nvmem_device_write(lpg_chan_sdam, SDAM_END_INDEX_OFFSET + chan->sdam_offset, 1, &hi_idx);
+	nvmem_device_write(lpg_chan_sdam, SDAM_START_INDEX_OFFSET + chan->sdam_offset, 1, &lo_idx);
+
+	val = RAMP_STEP_DURATION(chan->ramp_tick_ms);
+	nvmem_device_write(lpg_chan_sdam, SDAM_REG_RAMP_STEP_DURATION, 1, &val);
+}
+
 static void lpg_apply_lut_control(struct lpg_channel *chan)
 {
 	struct lpg *lpg = chan->lpg;
@@ -597,7 +733,10 @@ static void lpg_apply(struct lpg_channel *chan)
 	lpg_apply_pwm_value(chan);
 	lpg_apply_control(chan);
 	lpg_apply_sync(chan);
-	lpg_apply_lut_control(chan);
+	if (chan->lpg->lpg_chan_sdam)
+		lpg_sdam_apply_lut_control(chan);
+	else
+		lpg_apply_lut_control(chan);
 	lpg_enable_glitch(chan);
 }
 
@@ -622,6 +761,7 @@ static void lpg_brightness_set(struct lpg_led *led, struct led_classdev *cdev,
 			chan->ramp_enabled = false;
 		} else if (chan->pattern_lo_idx != chan->pattern_hi_idx) {
 			lpg_calc_freq(chan, NSEC_PER_MSEC);
+			lpg_sdam_configure_triggers(chan, 1);
 
 			chan->enabled = true;
 			chan->ramp_enabled = true;
@@ -649,8 +789,10 @@ static void lpg_brightness_set(struct lpg_led *led, struct led_classdev *cdev,
 		triled_set(lpg, triled_mask, triled_enabled);
 
 	/* Trigger start of ramp generator(s) */
-	if (lut_mask)
+	if (lut_mask) {
 		lpg_lut_sync(lpg, lut_mask);
+		lpg_set_pbs_trigger(lpg, lut_mask);
+	}
 }
 
 static int lpg_brightness_single_set(struct led_classdev *cdev,
@@ -836,18 +978,23 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 	 * If the specified pattern is a palindrome the ping pong mode is
 	 * enabled. In this scenario the delta_t of the middle entry (i.e. the
 	 * last in the programmed pattern) determines the "high pause".
+	 *
+	 * SDAM-based devices do not support "ping-pong", "low pause" or "high pause"
 	 */
 
 	/* Detect palindromes and use "ping pong" to reduce LUT usage */
-	for (i = 0; i < len / 2; i++) {
-		brightness_a = pattern[i].brightness;
-		brightness_b = pattern[len - i - 1].brightness;
-
-		if (brightness_a != brightness_b) {
-			ping_pong = false;
-			break;
+	if (lpg->lut_base) {
+		for (i = 0; i < len / 2; i++) {
+			brightness_a = pattern[i].brightness;
+			brightness_b = pattern[len - i - 1].brightness;
+
+			if (brightness_a != brightness_b) {
+				ping_pong = false;
+				break;
+			}
 		}
-	}
+	} else
+		ping_pong = false;
 
 	/* The pattern length to be written to the LUT */
 	if (ping_pong)
@@ -875,12 +1022,26 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 	if (delta_t >= BIT(9))
 		goto out_free_pattern;
 
-	/* Find "low pause" and "high pause" in the pattern */
-	lo_pause = pattern[0].delta_t;
-	hi_pause = pattern[actual_len - 1].delta_t;
+	/*
+	 * Find "low pause" and "high pause" in the pattern in the LUT case.
+	 * SDAM-based devices require equal duration of all steps
+	 */
+	if (lpg->lut_base) {
+		lo_pause = pattern[0].delta_t;
+		hi_pause = pattern[actual_len - 1].delta_t;
+	} else {
+		if (delta_t != pattern[0].delta_t || delta_t != pattern[actual_len - 1].delta_t)
+			goto out_free_pattern;
+	}
+
 
 	mutex_lock(&lpg->lock);
-	ret = lpg_lut_store(lpg, pattern, actual_len, &lo_idx, &hi_idx);
+
+	if (lpg->lut_base)
+		ret = lpg_lut_store(lpg, pattern, actual_len, &lo_idx, &hi_idx);
+	else
+		ret = lpg_lut_store_sdam(lpg, pattern, actual_len, &lo_idx, &hi_idx);
+
 	if (ret < 0)
 		goto out_unlock;
 
@@ -928,7 +1089,12 @@ static int lpg_pattern_mc_set(struct led_classdev *cdev,
 {
 	struct led_classdev_mc *mc = lcdev_to_mccdev(cdev);
 	struct lpg_led *led = container_of(mc, struct lpg_led, mcdev);
-	int ret;
+	unsigned int triled_mask = 0;
+	int ret, i;
+
+	for (i = 0; i < led->num_channels; i++)
+		triled_mask |= led->channels[i]->triled_mask;
+	triled_set(led->lpg, triled_mask, 0);
 
 	ret = lpg_pattern_set(led, pattern, len, repeat);
 	if (ret < 0)
@@ -953,6 +1119,8 @@ static int lpg_pattern_clear(struct lpg_led *led)
 
 	for (i = 0; i < led->num_channels; i++) {
 		chan = led->channels[i];
+		lpg_sdam_configure_triggers(chan, 0);
+		lpg_clear_pbs_trigger(chan->lpg, chan->lut_mask);
 		chan->pattern_lo_idx = 0;
 		chan->pattern_hi_idx = 0;
 	}
@@ -1188,8 +1356,8 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
 		cdev->brightness_set_blocking = lpg_brightness_mc_set;
 		cdev->blink_set = lpg_blink_mc_set;
 
-		/* Register pattern accessors only if we have a LUT block */
-		if (lpg->lut_base) {
+		/* Register pattern accessors if we have a LUT block or when using PPG */
+		if (lpg->lut_base || lpg->lpg_chan_sdam) {
 			cdev->pattern_set = lpg_pattern_mc_set;
 			cdev->pattern_clear = lpg_pattern_mc_clear;
 		}
@@ -1202,15 +1370,19 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
 		cdev->brightness_set_blocking = lpg_brightness_single_set;
 		cdev->blink_set = lpg_blink_single_set;
 
-		/* Register pattern accessors only if we have a LUT block */
-		if (lpg->lut_base) {
+		/* Register pattern accessors if we have a LUT block or when using PPG */
+		if (lpg->lut_base || lpg->lpg_chan_sdam) {
 			cdev->pattern_set = lpg_pattern_single_set;
 			cdev->pattern_clear = lpg_pattern_single_clear;
 		}
 	}
 
 	cdev->default_trigger = of_get_property(np, "linux,default-trigger", NULL);
-	cdev->max_brightness = LPG_RESOLUTION_9BIT - 1;
+
+	if (lpg->lpg_chan_sdam)
+		cdev->max_brightness = PPG_MAX_LED_BRIGHTNESS;
+	else
+		cdev->max_brightness = LPG_RESOLUTION_9BIT - 1;
 
 	if (!of_property_read_string(np, "default-state", &state) &&
 	    !strcmp(state, "on"))
@@ -1251,6 +1423,7 @@ static int lpg_init_channels(struct lpg *lpg)
 		chan->base = data->channels[i].base;
 		chan->triled_mask = data->channels[i].triled_mask;
 		chan->lut_mask = BIT(i);
+		chan->sdam_offset = data->channels[i].sdam_offset;
 
 		regmap_read(lpg->map, chan->base + LPG_SUBTYPE_REG, &chan->subtype);
 	}
@@ -1297,11 +1470,12 @@ static int lpg_init_lut(struct lpg *lpg)
 {
 	const struct lpg_data *data = lpg->data;
 
-	if (!data->lut_base)
+	if (!data->lut_size)
 		return 0;
 
-	lpg->lut_base = data->lut_base;
 	lpg->lut_size = data->lut_size;
+	if (data->lut_base)
+		lpg->lut_base = data->lut_base;
 
 	lpg->lut_bitmap = devm_bitmap_zalloc(lpg->dev, lpg->lut_size, GFP_KERNEL);
 	if (!lpg->lut_bitmap)
@@ -1310,6 +1484,48 @@ static int lpg_init_lut(struct lpg *lpg)
 	return 0;
 }
 
+static int lpg_init_sdam(struct lpg *lpg)
+{
+	int i, sdam_count, rc;
+	u8 val = 0;
+
+	sdam_count = of_property_count_strings(lpg->dev->of_node, "nvmem-names");
+	if (sdam_count <= 0)
+		return 0;
+
+	/* Get the SDAM device for LPG/LUT config */
+	lpg->lpg_chan_sdam = devm_nvmem_device_get(lpg->dev, "lpg_chan_sdam");
+	if (IS_ERR(lpg->lpg_chan_sdam))
+		return dev_err_probe(lpg->dev, PTR_ERR(lpg->lpg_chan_sdam),
+				"Failed to get LPG chan SDAM device\n");
+
+	lpg->pbs_dev = get_pbs_client_device(lpg->dev);
+	if (IS_ERR(lpg->pbs_dev))
+		return dev_err_probe(lpg->dev, PTR_ERR(lpg->pbs_dev),
+				"Failed to get PBS client device\n");
+
+	for (i = 0; i < lpg->num_channels; i++) {
+		struct lpg_channel *chan = &lpg->channels[i];
+
+		if (chan->sdam_offset) {
+			rc = nvmem_device_write(lpg->lpg_chan_sdam,
+				SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET + chan->sdam_offset, 1, &val);
+			if (rc < 0)
+				return rc;
+
+			rc = lpg_sdam_configure_triggers(chan, 0);
+			if (rc < 0)
+				return rc;
+
+			rc = lpg_clear_pbs_trigger(chan->lpg, chan->lut_mask);
+			if (rc < 0)
+				return rc;
+		}
+	}
+
+	return 0;
+}
+
 static int lpg_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
@@ -1346,6 +1562,10 @@ static int lpg_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	ret = lpg_init_sdam(lpg);
+	if (ret < 0)
+		return ret;
+
 	ret = lpg_init_lut(lpg);
 	if (ret < 0)
 		return ret;
-- 
2.41.0

