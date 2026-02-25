Return-Path: <linux-pwm+bounces-8159-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LNANq/wnmnoXwQAu9opvQ
	(envelope-from <linux-pwm+bounces-8159-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Feb 2026 13:53:03 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED96197A7F
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Feb 2026 13:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5A2C301C89E
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Feb 2026 12:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC5E3A1D0F;
	Wed, 25 Feb 2026 12:52:24 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EF139902C;
	Wed, 25 Feb 2026 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023944; cv=none; b=USmhyDGiXAtumQxJNMMfYQ7yOMXvxn1aMhG9SpANte5v8WhfMDfAAXwhoFd3lpMyPeUHxOHlV/psk00RU+qVWcp23qU1f8yQmHevyI5KF75AWPPSi39W0bV8uE2poYy/IemyVig8IWLjiS8epeHJ52CEuycpgn1sAseK/DnvLaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023944; c=relaxed/simple;
	bh=R5MwjWSydbdyQue8I2dgG91hyACCSZpNi8sAhk1mnS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iPumFbydklRpv4BH9sOpMIRq8/f6c8A8HuwL0nLGmQl+SfOXSkFFIfPRA7IcMUUyAAFMwWxxvO+dZfGSg5HKZ6lTK2snSVES52VANz+Qny1N6L3W4GHLzo3Qluiyzns023ERa66Rz2cq6Tl17Fh1ViPOyiS3JFJA6NFEKopKiBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6ED1329ABCA;
	Wed, 25 Feb 2026 13:52:12 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id qwRo6-6h9Zeo; Wed, 25 Feb 2026 13:52:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3D5ED29ABD6;
	Wed, 25 Feb 2026 13:52:11 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hS1Cfun_JASb; Wed, 25 Feb 2026 13:52:11 +0100 (CET)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id DEEB929ABCA;
	Wed, 25 Feb 2026 13:52:10 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: linux-pwm@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	ukleinek@kernel.org,
	linux@roeck-us.net,
	julian.friedrich@frequentis.com,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH] [RFC] hwmon: nct6775: Register fan PWMs as PWM chip
Date: Wed, 25 Feb 2026 13:51:59 +0100
Message-ID: <20260225125159.20822-1-richard@nod.at>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8159-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[nod.at];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richard@nod.at,linux-pwm@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nod.at:mid,nod.at:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5ED96197A7F
X-Rspamd-Action: no action

The Nuvoton 6775 chip family also offers PWM functionality to control
various fans. Depending on the hardware design, the PWM can also be
used for other purposes, such as controlling a display backlight.

Historically, the driver implemented its own sysfs-based interface to
control the PWMs. This made it impossible to use the PWM as a backend
for other drivers, such as pwm-backlight.

This patch registers the PWM functionality as a PWM chip within the
PWM subsystem. Since the Nuvoton chip has non-trivial control logic,
the following constraints exist:

 - Exporting a PWM for external use is only allowed when the fan mode
   is set to manual or off.
 - As soon as a PWM is exported, changing its configuration is no
   longer possible through the hwmon sysfs interface, reading is
   still allowed.
 - Changing the PWM period is not supported. IMHO, it is too risky
   since the PWMs usually control system fans and similar components.
 - Reading and decoding the current PWM period is only supported for
   one chip variant so far, for all other chips, a fixed period of
   100ms is assumed.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/hwmon/nct6775-core.c | 249 +++++++++++++++++++++++++++++++++--
 drivers/hwmon/nct6775.h      |   3 +
 2 files changed, 238 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index 79bc67ffb9986..bc3b0fb505c39 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -56,6 +56,7 @@
 #include <linux/bitops.h>
 #include <linux/nospec.h>
 #include <linux/regmap.h>
+#include <linux/pwm.h>
 #include "lm75.h"
 #include "nct6775.h"
=20
@@ -770,6 +771,7 @@ static const u16 NCT6106_FAN_PULSE_SHIFT[] =3D { 0, 2=
, 4 };
 static const u8 NCT6106_REG_PWM_MODE[] =3D { 0xf3, 0xf3, 0xf3, 0, 0 };
 static const u8 NCT6106_PWM_MODE_MASK[] =3D { 0x01, 0x02, 0x04, 0, 0 };
 static const u16 NCT6106_REG_PWM_READ[] =3D { 0x4a, 0x4b, 0x4c, 0xd8, 0x=
d9 };
+static const u16 NCT6106_REG_PWM_FREQ[] =3D { 0xf0, 0xf1, 0xf2 };
 static const u16 NCT6106_REG_FAN_MODE[] =3D { 0x113, 0x123, 0x133 };
 static const u16 NCT6106_REG_TEMP_SOURCE[] =3D {
 	0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5 };
@@ -2482,6 +2484,9 @@ store_pwm_mode(struct device *dev, struct device_at=
tribute *attr,
 	int err;
 	u16 reg;
=20
+	if (data->pwm_exported[nr])
+		return -EBUSY;
+
 	err =3D kstrtoul(buf, 10, &val);
 	if (err < 0)
 		return err;
@@ -2510,13 +2515,8 @@ store_pwm_mode(struct device *dev, struct device_a=
ttribute *attr,
 	return err ? : count;
 }
=20
-static ssize_t
-show_pwm(struct device *dev, struct device_attribute *attr, char *buf)
+static int read_pwm(struct nct6775_data *data, int nr, int index)
 {
-	struct nct6775_data *data =3D nct6775_update_device(dev);
-	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
-	int nr =3D sattr->nr;
-	int index =3D sattr->index;
 	int err;
 	u16 pwm;
=20
@@ -2535,18 +2535,87 @@ show_pwm(struct device *dev, struct device_attrib=
ute *attr, char *buf)
 		pwm =3D data->pwm[index][nr];
 	}
=20
-	return sprintf(buf, "%d\n", pwm);
+	return pwm;
+}
+
+static u64 nct6106d_calc_period(u8 val)
+{
+	/*
+	 * Case 1: Bit 7 is set
+	 * --------------------
+	 *
+	 * frequency f in kHz is 92.5 / (val[6:0] + 1)
+	 * persiod_ns =3D 1000000 / (92.5 / (val[6:0] + 1))
+	 * ...rearrange
+	 * persiod_ns =3D (1000000 * (val[6:0] + 1)) / 92.5
+	 * ...eleminate decimals places by muliplying with 2 / 2
+	 * persiod_ns =3D (2000000 * (val[6:0] + 1)) / 185
+	 *
+	 * Case 2: Bit 7 is unset
+	 * ----------------------
+	 *
+	 * frequency f in Hz is 1008 / (val[3:0] + 1)
+	 * persiod_ns =3D 1000000000 / (1008 / (val[3:0] + 1))
+	 * ...rearrange
+	 * persiod_ns =3D (1000000000 * (val[3:0] + 1)) / 1008
+	 */
+	if (val & 0x80)
+		return DIV_ROUND_CLOSEST_ULL(2000000ULL * ((val & 0x7F) + 1), 185);
+	else
+		return DIV_ROUND_CLOSEST_ULL(1000000000ULL * ((val & 0x0F) + 1), 1008)=
;
+}
+
+static int get_pwm_period(struct nct6775_data *data, int nr, u64 *period=
)
+{
+	int err;
+	u16 val;
+
+	if (!data->REG_PWM_FREQ) {
+		/*
+		 * Use 100ms period if PWM frequency can't be obtained.
+		 */
+		*period =3D 100000000ULL;
+		return 0;
+	}
+
+	if (!data->pwm_freq[nr]) {
+		err =3D nct6775_read_value(data, data->REG_PWM_FREQ[nr], &val);
+		if (err)
+			return err;
+
+		data->pwm_freq[nr] =3D val & 0xFF;
+	}
+
+	switch (data->kind) {
+	case nct6106:
+		*period =3D nct6106d_calc_period(data->pwm_freq[nr]);
+		break;
+	default:
+		WARN_ONCE(1, "REG_PWM_FREQ configured but no calc function");
+		return -EINVAL;
+	}
+
+	return 0;
 }
=20
 static ssize_t
-store_pwm(struct device *dev, struct device_attribute *attr, const char =
*buf,
-	  size_t count)
+show_pwm(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	struct nct6775_data *data =3D nct6775_update_device(dev);
 	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
 	int nr =3D sattr->nr;
 	int index =3D sattr->index;
-	unsigned long val;
+	u16 pwm;
+
+	pwm =3D read_pwm(data, nr, index);
+	if (pwm < 0)
+		return pwm;
+
+	return sprintf(buf, "%d\n", pwm);
+}
+
+static int write_pwm(struct nct6775_data *data, int nr, int index, unsig=
ned long val)
+{
 	int minval[7] =3D { 0, 1, 1, data->pwm[2][nr], 0, 0, 0 };
 	int maxval[7]
 	  =3D { 255, 255, data->pwm[3][nr] ? : 255, 255, 255, 255, 255 };
@@ -2560,9 +2629,6 @@ store_pwm(struct device *dev, struct device_attribu=
te *attr, const char *buf,
 	if (index =3D=3D 0 && data->pwm_enable[nr] > manual)
 		return -EBUSY;
=20
-	err =3D kstrtoul(buf, 10, &val);
-	if (err < 0)
-		return err;
 	val =3D clamp_val(val, minval[index], maxval[index]);
=20
 	mutex_lock(&data->update_lock);
@@ -2581,6 +2647,28 @@ store_pwm(struct device *dev, struct device_attrib=
ute *attr, const char *buf,
 	}
 out:
 	mutex_unlock(&data->update_lock);
+
+	return 0;
+}
+
+static ssize_t
+store_pwm(struct device *dev, struct device_attribute *attr, const char =
*buf,
+	  size_t count)
+{
+	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
+	struct nct6775_data *data =3D dev_get_drvdata(dev);
+	unsigned long val;
+	int err;
+
+	if (data->pwm_exported[sattr->nr])
+		return -EBUSY;
+
+	err =3D kstrtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	err =3D write_pwm(data, sattr->nr, sattr->index, val);
+
 	return err ? : count;
 }
=20
@@ -2681,6 +2769,9 @@ store_pwm_enable(struct device *dev, struct device_=
attribute *attr,
 	int err;
 	u16 reg;
=20
+	if (data->pwm_exported[nr])
+		return -EBUSY;
+
 	err =3D kstrtoul(buf, 10, &val);
 	if (err < 0)
 		return err;
@@ -3501,6 +3592,131 @@ static int add_temp_sensors(struct nct6775_data *=
data, const u16 *regp,
 	return 0;
 }
=20
+static int nct6775_pwm_round_waveform_fromhw(struct pwm_chip *chip,
+					     struct pwm_device *pwm,
+					     const void *_wfhw,
+					     struct pwm_waveform *wf)
+{
+	struct nct6775_data *data =3D pwmchip_get_drvdata(chip);
+	const u8 *wfhw =3D _wfhw;
+
+	if (get_pwm_period(data, pwm->hwpwm, &wf->period_length_ns))
+		return 1;
+
+	wf->duty_length_ns =3D mul_u64_u64_div_u64(*wfhw, wf->period_length_ns,=
 255);
+	wf->duty_offset_ns =3D 0;
+
+	return 0;
+}
+
+static int nct6775_pwm_round_waveform_tohw(struct pwm_chip *chip,
+					   struct pwm_device *pwm,
+					   const struct pwm_waveform *wf,
+					   void *_wfhw)
+{
+	struct nct6775_data *data =3D pwmchip_get_drvdata(chip);
+	u8 *wfhw =3D _wfhw;
+	u64 cur_period;
+
+	if (wf->period_length_ns =3D=3D 0) {
+		*wfhw =3D 0;
+		return 0;
+	}
+
+	if (get_pwm_period(data, pwm->hwpwm, &cur_period))
+		return 1;
+
+	if (wf->duty_length_ns >=3D cur_period)
+		*wfhw =3D 255;
+	else
+		*wfhw =3D mul_u64_u64_div_u64(wf->duty_length_ns, 255, wf->period_leng=
th_ns);
+
+	if (wf->period_length_ns !=3D cur_period)
+		return 1;
+
+	return 0;
+}
+
+
+static int nct6775_pwm_write_waveform(struct pwm_chip *chip,
+				      struct pwm_device *pwm,
+				      const void *_wfhw)
+{
+	struct nct6775_data *data =3D pwmchip_get_drvdata(chip);
+	const u8 *wfhw =3D _wfhw;
+
+	return write_pwm(data, pwm->hwpwm, 0, *wfhw);
+}
+
+static int nct6775_pwm_read_waveform(struct pwm_chip *chip,
+				     struct pwm_device *pwm,
+				     void *_wfhw)
+{
+	struct nct6775_data *data =3D nct6775_update_device(pwmchip_parent(chip=
));
+	u8 *wfhw =3D _wfhw;
+	int val;
+
+	val =3D read_pwm(data, pwm->hwpwm, 0);
+	if (val < 0)
+		return val;
+
+	*wfhw =3D (u8)val;
+
+	return 0;
+}
+
+static int nct6775_pwm_request(struct pwm_chip *chip, struct pwm_device =
*pwm)
+{
+	struct nct6775_data *data =3D pwmchip_get_drvdata(chip);
+
+	if (data->pwm_enable[pwm->hwpwm] > manual)
+		return -EBUSY;
+
+	data->pwm_exported[pwm->hwpwm] =3D true;
+
+	return 0;
+}
+
+static void nct6775_pwm_free(struct pwm_chip *chip, struct pwm_device *p=
wm)
+{
+	struct nct6775_data *data =3D pwmchip_get_drvdata(chip);
+
+	data->pwm_exported[pwm->hwpwm] =3D false;
+}
+
+static const struct pwm_ops nct6775_pwm_ops =3D {
+	.sizeof_wfhw =3D sizeof(u8),
+	.request =3D nct6775_pwm_request,
+	.free =3D nct6775_pwm_free,
+	.round_waveform_fromhw =3D nct6775_pwm_round_waveform_fromhw,
+	.round_waveform_tohw =3D nct6775_pwm_round_waveform_tohw,
+	.write_waveform =3D nct6775_pwm_write_waveform,
+	.read_waveform =3D nct6775_pwm_read_waveform,
+};
+
+static int nct6775_register_pwm_chip(struct device *dev, struct nct6775_=
data *data)
+{
+	struct pwm_chip *chip;
+	int ret;
+
+	if (data->pwm_num < 1)
+		return 0;
+
+	chip =3D devm_pwmchip_alloc(dev, data->pwm_num, 0);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	chip->ops =3D &nct6775_pwm_ops;
+	pwmchip_set_drvdata(chip, data);
+
+	ret =3D devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "Could not add PWM chip\n");
+
+
+	return 0;
+}
+
 int nct6775_probe(struct device *dev, struct nct6775_data *data,
 		  const struct regmap_config *regmapcfg)
 {
@@ -3563,6 +3779,7 @@ int nct6775_probe(struct device *dev, struct nct677=
5_data *data,
 		data->REG_PWM[6] =3D NCT6106_REG_WEIGHT_DUTY_BASE;
 		data->REG_PWM_READ =3D NCT6106_REG_PWM_READ;
 		data->REG_PWM_MODE =3D NCT6106_REG_PWM_MODE;
+		data->REG_PWM_FREQ =3D NCT6106_REG_PWM_FREQ;
 		data->PWM_MODE_MASK =3D NCT6106_PWM_MODE_MASK;
 		data->REG_AUTO_TEMP =3D NCT6106_REG_AUTO_TEMP;
 		data->REG_AUTO_PWM =3D NCT6106_REG_AUTO_PWM;
@@ -4379,6 +4596,10 @@ int nct6775_probe(struct device *dev, struct nct67=
75_data *data,
 	if (err)
 		return err;
=20
+	err =3D nct6775_register_pwm_chip(dev, data);
+	if (err)
+		return err;
+
 	if (data->have_tsi_temp) {
 		tsi_temp_tg.templates =3D nct6775_tsi_temp_template;
 		tsi_temp_tg.is_visible =3D nct6775_tsi_temp_is_visible;
diff --git a/drivers/hwmon/nct6775.h b/drivers/hwmon/nct6775.h
index 296eff99d0038..2032962f980f7 100644
--- a/drivers/hwmon/nct6775.h
+++ b/drivers/hwmon/nct6775.h
@@ -65,6 +65,7 @@ struct nct6775_data {
 				 * [5]=3Dweight_duty_step, [6]=3Dweight_duty_base
 				 */
 	const u16 *REG_PWM_READ;
+	const u16 *REG_PWM_FREQ;
=20
 	const u16 *REG_CRITICAL_PWM_ENABLE;
 	u8 CRITICAL_PWM_ENABLE_MASK;
@@ -137,6 +138,8 @@ struct nct6775_data {
 				 * [3]=3Dpwm_max, [4]=3Dpwm_step,
 				 * [5]=3Dweight_duty_step, [6]=3Dweight_duty_base
 				 */
+	u8 pwm_freq[NUM_FAN];
+	bool pwm_exported[NUM_FAN];
=20
 	u8 target_temp[NUM_FAN];
 	u8 target_temp_mask;
--=20
2.51.0


