Return-Path: <linux-pwm+bounces-8171-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBM2OMTEoWkVwQQAu9opvQ
	(envelope-from <linux-pwm+bounces-8171-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Feb 2026 17:22:28 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E511BAC1A
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Feb 2026 17:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E634E301BAA1
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Feb 2026 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF0F44B676;
	Fri, 27 Feb 2026 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rswczSH1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B735F44A723
	for <linux-pwm@vger.kernel.org>; Fri, 27 Feb 2026 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772209347; cv=none; b=dQHylSry4lnqByxsQkeuqbQr+cNrDeyUhHCYeMc6w4py/eZtPxfIFOb+G0s7NyhmioLG/h0W32KvLFqPkcsn5DGzi3oJBV4PGYx4loseYsQZkMwVKz5SYG2BlorAEIg47s2Z4IbMeZFOoJqveV82imq/wUSj/q0/vpffduxxrfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772209347; c=relaxed/simple;
	bh=kYPUvF4UEQ6LF3Cfn1dMvg5ZhqaE6uddWpC2I5dOrE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OkCfSXzCNehX/PMVpXthaRnCiccWUZ7h9mJJH1U8bxG3G97bWDKsgNq7XqlgAiVkrmzEX53mNVnpd6RPhAxHz0Q3Hv8INkOG5ce9mDxAwf65GhcqRO+p36X8UlWlY/OfnLnJ86m9APk4VEB80C/dwMh9LKaBeQHVrMU8F5z7s/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rswczSH1; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8B983C406A2;
	Fri, 27 Feb 2026 16:22:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 960485FE46;
	Fri, 27 Feb 2026 16:22:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 300941036949A;
	Fri, 27 Feb 2026 17:22:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772209341; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7EMUj9J2lzttg45PIgu6IItFeqZqS9pqZ7OM/QVePFo=;
	b=rswczSH1SlJ3ib4UceTBt2QrNTLqbu4jgZYIpkBLsPk28uhMaBBr0lmoF630EXDn/cVVad
	Rj2a59zPf4cPE1o332uykUPvr1hND4ki0kPYpG8gMA3ZQO3F3A7kXF4/eQOuEKXZilBpdl
	S3WocPtJBzBp3nB7Mimj0wSrQUCSctSFx+J4pwHmabJxlKopj52QuZ+w8saELtVeCmwofs
	yfSnU+1p+9eB5NAJxsoc8SGems/k7hkq1xmWhDHo+A/hR2ZbEeDwkN52yRShCiOZUOPTfI
	lWtYs/QmnzjrL293Im+XZRxo05cW2I+QXfB9Kr27Ihq4lx7BatRM+DxCcbexpQ==
Message-ID: <b64c6beb-afac-4df0-b687-5ab1e2b4baaf@bootlin.com>
Date: Fri, 27 Feb 2026 17:22:14 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] pwm: sun50i: Add H616 PWM support
To: Philipp Zabel <p.zabel@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: Paul Kocialkowski <paulk@sys-base.io>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260123093322.1327389-1-richard.genoud@bootlin.com>
 <20260123093322.1327389-3-richard.genoud@bootlin.com>
 <2938bcbbb46fdec1fd2629e11c28ce9cf09eee27.camel@pengutronix.de>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <2938bcbbb46fdec1fd2629e11c28ce9cf09eee27.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8171-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,baylibre.com,kernel.org,csie.org,gmail.com,sholland.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richard.genoud@bootlin.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88E511BAC1A
X-Rspamd-Action: no action

Le 26/02/2026 à 15:12, Philipp Zabel a écrit :
> On Fr, 2026-01-23 at 10:33 +0100, Richard Genoud wrote:
>> Add driver for Allwinner H616 PWM controller, supporting up to 6
>> channels.
>> Those channels output can be either a PWM signal output or a clock
>> output, thanks to the bypass.
>>
>> The channels are paired (0/1, 2/3 and 4/5) and each pair has a
>> prescaler/mux/gate.
>> Moreover, each channel has its own prescaler and bypass.
>>
>> The clock provider part of this driver is needed not only because the
>> H616 PWM controller provides also clocks when bypass is enabled, but
>> really because pwm-clock isn't fit to handle all cases here.
>> pwm-clock would work if the 100MHz clock is requested, but if a lower
>> clock is requested (like 24MHz), it will request a 42ns period to the
>> PWM driver which will happily serve, with the 100MHz clock as input a
>> 25MHz frequency and a duty cycle adjustable in the range [0-4]/4,
>> because that is a sane thing to do for a PWM.
>> The information missing is that a real clock is resquested, not a PWM.
>>
>> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
>> ---
>>   drivers/pwm/Kconfig           |  12 +
>>   drivers/pwm/Makefile          |   1 +
>>   drivers/pwm/pwm-sun50i-h616.c | 959 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 972 insertions(+)
>>   create mode 100644 drivers/pwm/pwm-sun50i-h616.c
>>
> [...]
>> diff --git a/drivers/pwm/pwm-sun50i-h616.c b/drivers/pwm/pwm-sun50i-h616.c
>> new file mode 100644
>> index 000000000000..02a8e2d39f86
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-sun50i-h616.c
>> @@ -0,0 +1,959 @@
> [...]
>> +static int h616_pwm_init_clocks(struct platform_device *pdev,
>> +				struct h616_pwm_chip *h616chip)
>> +{
>> +	struct clk_pwm_pdata *pdata;
>> +	struct device *dev = &pdev->dev;
>> +	int num_clocks = 0;
>> +	int ret;
>> +
>> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> +	if (!pdata)
>> +		return dev_err_probe(dev, -ENOMEM,
>> +				     "Failed to allocate clk_pwm_pdata\n");
>> +
>> +	while (pwmcc_data[num_clocks].name)
>> +		num_clocks++;
>> +
>> +	pdata->hw_data = devm_kzalloc(dev, struct_size(pdata->hw_data, hws, num_clocks),
>> +				      GFP_KERNEL);
>> +	if (!pdata->hw_data)
>> +		return dev_err_probe(dev, -ENOMEM,
>> +				     "Failed to allocate hw clocks\n");
>> +
>> +	pdata->hw_data->num = num_clocks;
>> +	pdata->reg = h616chip->base;
>> +
>> +	spin_lock_init(&pdata->lock);
>> +
>> +	for (int i = 0; i < num_clocks; i++) {
>> +		struct clk_hw **hw = &pdata->hw_data->hws[i];
>> +
>> +		ret = h616_add_composite_clk(&pwmcc_data[i], pdata->reg,
>> +					     &pdata->lock, dev, hw);
>> +		if (ret) {
>> +			dev_err_probe(dev, ret,
>> +				      "Failed to register hw clock %s\n",
>> +				      pwmcc_data[i].name);
>> +			for (i--; i >= 0; i--)
>> +				clk_hw_unregister_composite(pdata->hw_data->hws[i]);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	h616chip->clk_pdata = pdata;
>> +
>> +	return 0;
>> +}
>> +
>> +static int h616_pwm_probe(struct platform_device *pdev)
>> +{
>> +	const struct h616_pwm_data *data;
>> +	struct device *dev = &pdev->dev;
>> +	struct h616_pwm_chip *h616chip;
>> +	struct pwm_chip *chip;
>> +	int ret;
>> +
>> +	data = of_device_get_match_data(dev);
>> +	if (!data)
>> +		return dev_err_probe(dev, -ENODEV,
>> +				     "Missing specific data structure\n");
>> +
>> +	chip = devm_pwmchip_alloc(dev, data->npwm, sizeof(*h616chip));
>> +	if (IS_ERR(chip))
>> +		return dev_err_probe(dev, PTR_ERR(chip),
>> +				     "Failed to allocate pwmchip\n");
>> +
>> +	h616chip = h616_pwm_from_chip(chip);
>> +	h616chip->data = data;
>> +	h616chip->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(h616chip->base))
>> +		return dev_err_probe(dev, PTR_ERR(h616chip->base),
>> +				     "Failed to get PWM base address\n");
>> +
>> +	h616chip->bus_clk = devm_clk_get_enabled(dev, "bus");
>> +	if (IS_ERR(h616chip->bus_clk))
>> +		return dev_err_probe(dev, PTR_ERR(h616chip->bus_clk),
>> +				     "Failed to get bus clock\n");
>> +
>> +	h616chip->channels = devm_kmalloc_array(dev, data->npwm,
>> +						sizeof(*(h616chip->channels)),
>> +						GFP_KERNEL);
>> +	if (!h616chip->channels)
>> +		return dev_err_probe(dev, -ENOMEM,
>> +				     "Failed to allocate %d channels array\n",
>> +				     data->npwm);
>> +
>> +	h616chip->rst = devm_reset_control_get_shared(dev, NULL);
>> +	if (IS_ERR(h616chip->rst))
>> +		return dev_err_probe(dev, PTR_ERR(h616chip->rst),
>> +				     "Failed to get reset control\n");
>> +
>> +	chip->ops = &h616_pwm_ops;
>> +
>> +	ret = h616_pwm_init_clocks(pdev, h616chip);
>> +	if (ret)
>> +		return ret;
>> +
>> +	for (unsigned int i = 0; i < data->npwm; i++) {
>> +		struct h616_pwm_channel *chan = &h616chip->channels[i];
>> +		struct clk_hw **hw = &h616chip->clk_pdata->hw_data->hws[i];
>> +
>> +		chan->pwm_clk = devm_clk_hw_get_clk(dev, *hw, NULL);
>> +		if (IS_ERR(chan->pwm_clk)) {
>> +			ret = dev_err_probe(dev, PTR_ERR(chan->pwm_clk),
>> +					    "Failed to register PWM clock %d\n", i);
>> +			goto err_get_clk;
>> +		}
>> +		chan->mode = H616_PWM_MODE_NONE;
>> +	}
>> +
>> +	ret = devm_of_clk_add_hw_provider(dev, h616_pwm_of_clk_get, h616chip);
>> +	if (ret) {
>> +		dev_err_probe(dev, ret, "Failed to add HW clock provider\n");
>> +		goto err_add_clk_provider;
>> +	}
>> +
>> +	/* Deassert reset */
>> +	ret = reset_control_deassert(h616chip->rst);
>> +	if (ret) {
>> +		dev_err_probe(dev, ret, "Cannot deassert reset control\n");
>> +		goto err_ctrl_deassert;
>> +	}
>> +
>> +	ret = pwmchip_add(chip);
>> +	if (ret < 0) {
>> +		dev_err_probe(dev, ret, "Failed to add PWM chip\n");
>> +		goto err_pwm_add;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, chip);
>> +
>> +	return 0;
>> +
>> +err_pwm_add:
>> +	reset_control_assert(h616chip->rst);
>> +
>> +err_ctrl_deassert:
>> +err_add_clk_provider:
>> +err_get_clk:
>> +	for (unsigned int i = 0; i < h616chip->clk_pdata->hw_data->num; i++)
>> +		clk_hw_unregister_composite(h616chip->clk_pdata->hw_data->hws[i]);
> 
> Won't this try to unregister the clk_hw before the pwm_clk derived from
> it? You could place this in a devres action to correct the cleanup
> order and get rid of the duplicated cleanup in h616_pwm_remove().
Ah! You're right!

> 
> I think you could even use devm_pwmchip_add() and
> devm_reset_control_get_shared_deasserted() and remove h616_pwm_remove
> entirely.
Nice!
I'll do that.

Thanks!

Regards,
Richard

> 
> regards
> Philipp


