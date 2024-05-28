Return-Path: <linux-pwm+bounces-2274-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38E48D2863
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 00:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5920E28470E
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 22:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AD413F422;
	Tue, 28 May 2024 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="bnbaLEP/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264F813E8B6
	for <linux-pwm@vger.kernel.org>; Tue, 28 May 2024 22:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716937008; cv=none; b=HQQZ7UqrBH6hrAAoC2YiCZhvBtCcKXExV8Mb/YuAdZwX4DLMV1mPVL+1A1xAWRwlqwYsq/IYfwLnEZc3RaPZK47wwgF7qKtMWstDr2F1C/xPJH1SGTm/ynoqKkPL+IvePbmRuRGVlbaEmSBCoFZqDcaED5FWQXo3PEdE9cMEb00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716937008; c=relaxed/simple;
	bh=Mr4R4Ovc/1GYphW/4sCiClMVCQOYp+QcgAN/leUXXoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIqWVjiw0LHJJf4aB62aAntxuk1vz/5awqEjPafJO9PCPT8BHXeazQa/yRIN7KWmJYDzkc5xUerCnAZU2r1SpmPvZJ1DHYhnr5NZpb4zQXNLaG7s5Ei0hnQxqgQvC7+YURpZAlOWKilka5RbqDNxw4e02G5j601iEFjqdbrN+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=bnbaLEP/; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1C1F92C083B;
	Wed, 29 May 2024 10:56:43 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1716937003;
	bh=sDg5hLIzdRqL90fe0fSd0Q9S7I111GJVwkN3eDzWGyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bnbaLEP/q1CLAkKSbqbJz5nHx75HpfY0Tz3fDpLUQsY0a7vQr0dOc5OLfCGvvWvZv
	 GLpNyIRO84IjcfMewkU2QJBoDebspW6SlBaN2bwAqkcq5SOsR2DV8HaNKedulWOXVH
	 I5Wja+o9Rek7/jyZRInQi+SPv8S0pyGnJ3PI7YEZ+2YQKKX9F3DhHWPrM0SHX6xlpc
	 GDzbPBMbivAFx7FJJurxBQj4CAf6xjgqnJUZhBjdoNsPpIMyS6PhS3caUgj+UNWtnI
	 r7F8i/pM05glr1XmOKK7FbP3Nd9oREdR0Sal1lmpsKSJC9IJnN+I+SxgNdGdmF6EhL
	 T2Fiq5cxe77qg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6656612a0003>; Wed, 29 May 2024 10:56:42 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id AECEC13EE84;
	Wed, 29 May 2024 10:56:42 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id AC2C4280A37; Wed, 29 May 2024 10:56:42 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ukleinek@kernel.org
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v4 3/3] hwmon: (adt7475) Add support for configuring initial PWM state
Date: Wed, 29 May 2024 10:56:38 +1200
Message-ID: <20240528225638.1211676-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528225638.1211676-1-chris.packham@alliedtelesis.co.nz>
References: <20240528225638.1211676-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=6656612a a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=TpHVaj0NuXgA:10 a=cN3pOM3YZmoqkZYst0EA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

By default the PWM duty cycle in hardware is 100%. On some systems this
can cause unwanted fan noise. Add the ability to specify the fan
connections and initial state of the PWMs via device properties.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v4:
    - Support DT and ACPI fwnodes
    - Put PWM into manual mode
    Changes in v3:
    - Use the pwm provider/consumer bindings
    Changes in v2:
    - Use correct device property string for frequency
    - Allow -EINVAL and only warn on error
    - Use a frequency of 0 to indicate that the hardware should be left a=
s-is

 drivers/hwmon/adt7475.c | 112 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 4224ffb30483..b5c58e3cda03 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -21,6 +21,8 @@
 #include <linux/of.h>
 #include <linux/util_macros.h>
=20
+#include <dt-bindings/pwm/pwm.h>
+
 /* Indexes for the sysfs hooks */
=20
 #define INPUT		0
@@ -1662,6 +1664,112 @@ static int adt7475_set_pwm_polarity(struct i2c_cl=
ient *client)
 	return 0;
 }
=20
+struct adt7475_pwm_config {
+	int index;
+	int freq;
+	int flags;
+	int duty;
+};
+
+static int adt7475_pwm_properties_parse_reference_args(struct fwnode_han=
dle *fwnode,
+						       struct adt7475_pwm_config *cfg)
+{
+	int ret;
+	struct fwnode_reference_args args =3D {};
+
+	ret =3D fwnode_property_get_reference_args(fwnode, "pwms", "#pwm-cells"=
, 0, 0, &args);
+	if (ret)
+		return ret;
+
+	if (args.nargs !=3D 4) {
+		fwnode_handle_put(args.fwnode);
+		return -EINVAL;
+	}
+
+	cfg->index =3D args.args[0];
+	cfg->freq =3D find_closest(args.args[1], pwmfreq_table, ARRAY_SIZE(pwmf=
req_table));
+	cfg->flags =3D args.args[2];
+	cfg->duty =3D clamp_val(args.args[3], 0, 0xFF);
+
+	fwnode_handle_put(args.fwnode);
+
+	return 0;
+}
+
+static int adt7475_pwm_properties_parse_args(struct fwnode_handle *fwnod=
e,
+					     struct adt7475_pwm_config *cfg)
+{
+	int ret;
+	u32 args[4] =3D {};
+
+	ret =3D fwnode_property_read_u32_array(fwnode, "pwms", args, ARRAY_SIZE=
(args));
+	if (ret)
+		return ret;
+
+	cfg->index =3D args[0];
+	cfg->freq =3D find_closest(args[1], pwmfreq_table, ARRAY_SIZE(pwmfreq_t=
able));
+	cfg->flags =3D args[2];
+	cfg->duty =3D clamp_val(args[3], 0, 0xFF);
+
+	return 0;
+}
+
+static int adt7475_fan_pwm_config(struct i2c_client *client)
+{
+	struct adt7475_data *data =3D i2c_get_clientdata(client);
+	struct fwnode_handle *child;
+	struct adt7475_pwm_config cfg =3D {};
+	int ret;
+
+	device_for_each_child_node(&client->dev, child) {
+		if (!fwnode_property_present(child, "pwms"))
+			continue;
+
+		if (is_of_node(child))
+			ret =3D adt7475_pwm_properties_parse_reference_args(child, &cfg);
+		else
+			ret =3D adt7475_pwm_properties_parse_args(child, &cfg);
+
+		if (cfg.index >=3D ADT7475_PWM_COUNT)
+			return -EINVAL;
+
+		ret =3D adt7475_read(PWM_CONFIG_REG(cfg.index));
+		if (ret < 0)
+			return ret;
+		data->pwm[CONTROL][cfg.index] =3D ret;
+		if (cfg.flags & PWM_POLARITY_INVERTED)
+			data->pwm[CONTROL][cfg.index] |=3D BIT(4);
+		else
+			data->pwm[CONTROL][cfg.index] &=3D ~BIT(4);
+
+		/* Force to manual mode so PWM values take effect */
+		data->pwm[CONTROL][cfg.index] &=3D ~0xE0;
+		data->pwm[CONTROL][cfg.index] |=3D 0x07 << 5;
+
+		ret =3D i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(cfg.index),
+						data->pwm[CONTROL][cfg.index]);
+		if (ret)
+			return ret;
+
+		data->pwm[INPUT][cfg.index] =3D cfg.duty;
+		ret =3D i2c_smbus_write_byte_data(client, PWM_REG(cfg.index),
+						data->pwm[INPUT][cfg.index]);
+		if (ret)
+			return ret;
+
+		data->range[cfg.index] =3D adt7475_read(TEMP_TRANGE_REG(cfg.index));
+		data->range[cfg.index] &=3D ~0xf;
+		data->range[cfg.index] |=3D cfg.freq;
+
+		ret =3D i2c_smbus_write_byte_data(client, TEMP_TRANGE_REG(cfg.index),
+						data->range[cfg.index]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int adt7475_probe(struct i2c_client *client)
 {
 	enum chips chip;
@@ -1778,6 +1886,10 @@ static int adt7475_probe(struct i2c_client *client=
)
 	if (ret && ret !=3D -EINVAL)
 		dev_warn(&client->dev, "Error configuring pwm polarity\n");
=20
+	ret =3D adt7475_fan_pwm_config(client);
+	if (ret)
+		dev_warn(&client->dev, "Error %d configuring fan/pwm\n", ret);
+
 	/* Start monitoring */
 	switch (chip) {
 	case adt7475:
--=20
2.45.1


