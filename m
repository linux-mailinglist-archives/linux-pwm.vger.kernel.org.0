Return-Path: <linux-pwm+bounces-8453-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGHrISbXzWn1iAYAu9opvQ
	(envelope-from <linux-pwm+bounces-8453-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 02 Apr 2026 04:40:38 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D5D382C31
	for <lists+linux-pwm@lfdr.de>; Thu, 02 Apr 2026 04:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD593302F392
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Apr 2026 02:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C061F33FE02;
	Thu,  2 Apr 2026 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdDlLgTc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A78133DEF9;
	Thu,  2 Apr 2026 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775097618; cv=none; b=RJsxKp9xDjz0Ue6H9dRjd76Ep95y9Nsa1QgQQH/ITOlW8tnUY4QWYgBlvtdoL8rXwLGKan3CleTSQdKKjDzznmw8oIJHsxGZnVg1rBALggvzHwZLPlT2x2hYO5X2/+XaCBZTuQfiEkUhg9dFmJRUlc0cekVz+S/0AHa2RYW61Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775097618; c=relaxed/simple;
	bh=4SdS+lHyJtTa2/Ms9Wv2AX4lHTJvDixvSJNqF+OkoRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aooT2j20kwcGT5CfFly9g8O5BnB9cXLgt1skaLsd7scoo/95U+n3LpaVgADD6gVLqkftswqMFXK984wxX79HwIiz5vwCKX7XsoLvmprbyXaW7UrtZe463WJt8jCNLpvlcaMuSh3aG3DrgtyKPraRXzx99DjocO4EEB7aDc2yjNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdDlLgTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CF59C19421;
	Thu,  2 Apr 2026 02:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775097618;
	bh=4SdS+lHyJtTa2/Ms9Wv2AX4lHTJvDixvSJNqF+OkoRQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gdDlLgTcIWHHBa0BBSkuXr7+5Mc71LCm3SKnt+e2bILq82u9TiWjX+JLLZOQZ74pj
	 SASzrPRtLWsHMPmo3XrVSXJkLyMLkRKe070lV+/teMbXuGNwOt/E/DTk1kx+rLzxw0
	 gYXZI/hgkXW1ssoGbOH1EBSu+cVpVczd5TRrswsO0+f0cYleGVMVPnbwe6ocmcgCnd
	 E9WgjV+ZvcWWRBVDsLrJKs0JnI4p3FL2O/1tKvewkAOTM1gGghWJtYaNheZ8gBV3rh
	 U7wOhEtakGHf+o+9HsGeCxjihr1gKe08VLMKv7QF4GWY416qzCduQ2peEMRhzpDc4+
	 L64HvAA9c5DJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE4E1112279;
	Thu,  2 Apr 2026 02:40:18 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 02 Apr 2026 02:40:16 +0000
Subject: [PATCH v2 2/2] pwm: meson: Add support for Amlogic S7
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-s6-s7-pwm-v2-2-657dce040956@amlogic.com>
References: <20260402-s6-s7-pwm-v2-0-657dce040956@amlogic.com>
In-Reply-To: <20260402-s6-s7-pwm-v2-0-657dce040956@amlogic.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775097616; l=2781;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=o49tWz26WxnJOme5RKrdAld7mCVrpPGE+v52KlxAPOc=;
 b=ZCG8B2cWMv72BgpxPUZFlE4mKV/iyUMBSOfTUhkafcR/E4XCYxDHR+ni2AbmTmY920F+TCJi4
 pkcdl4Qr2F1DRXBjIoWyboQEN8XmeDGS2lf5Wly1Kb+9CasM+VeAdlH
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8453-lists,linux-pwm=lfdr.de,xianwei.zhao.amlogic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,baylibre.com,googlemail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[xianwei.zhao@amlogic.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amlogic.com:email,amlogic.com:replyto,amlogic.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1D5D382C31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add support for Amlogic S7 PWM. Amlogic S7 different from the
previous SoCs, a controller includes one pwm, at the same time,
the controller has only one input clock source.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/pwm/pwm-meson.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 8c6bf3d49753..7a43c42ef3d6 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -113,6 +113,7 @@ struct meson_pwm_data {
 	int (*channels_init)(struct pwm_chip *chip);
 	bool has_constant;
 	bool has_polarity;
+	bool single_pwm;
 };
 
 struct meson_pwm {
@@ -503,6 +504,18 @@ static void meson_pwm_s4_put_clk(void *data)
 	clk_put(clk);
 }
 
+static int meson_pwm_init_channels_s7(struct pwm_chip *chip)
+{
+	struct device *dev = pwmchip_parent(chip);
+	struct meson_pwm *meson = to_meson_pwm(chip);
+
+	meson->channels[0].clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(meson->channels[0].clk))
+		return dev_err_probe(dev, PTR_ERR(meson->channels[0].clk),
+				     "Failed to get clk\n");
+	return 0;
+}
+
 static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
 {
 	struct device *dev = pwmchip_parent(chip);
@@ -592,6 +605,13 @@ static const struct meson_pwm_data pwm_s4_data = {
 	.has_polarity = true,
 };
 
+static const struct meson_pwm_data pwm_s7_data = {
+	.channels_init = meson_pwm_init_channels_s7,
+	.has_constant = true,
+	.has_polarity = true,
+	.single_pwm = true,
+};
+
 static const struct of_device_id meson_pwm_matches[] = {
 	{
 		.compatible = "amlogic,meson8-pwm-v2",
@@ -642,6 +662,10 @@ static const struct of_device_id meson_pwm_matches[] = {
 		.compatible = "amlogic,meson-s4-pwm",
 		.data = &pwm_s4_data
 	},
+	{
+		.compatible = "amlogic,s7-pwm",
+		.data = &pwm_s7_data
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, meson_pwm_matches);
@@ -650,9 +674,11 @@ static int meson_pwm_probe(struct platform_device *pdev)
 {
 	struct pwm_chip *chip;
 	struct meson_pwm *meson;
-	int err;
+	const struct meson_pwm_data *pdata = of_device_get_match_data(&pdev->dev);
+	int err, npwm;
 
-	chip = devm_pwmchip_alloc(&pdev->dev, MESON_NUM_PWMS, sizeof(*meson));
+	npwm = pdata->single_pwm ? 1 : MESON_NUM_PWMS;
+	chip = devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*meson));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	meson = to_meson_pwm(chip);
@@ -664,7 +690,7 @@ static int meson_pwm_probe(struct platform_device *pdev)
 	spin_lock_init(&meson->lock);
 	chip->ops = &meson_pwm_ops;
 
-	meson->data = of_device_get_match_data(&pdev->dev);
+	meson->data = pdata;
 
 	err = meson->data->channels_init(chip);
 	if (err < 0)

-- 
2.52.0



