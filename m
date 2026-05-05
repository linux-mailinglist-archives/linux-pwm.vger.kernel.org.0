Return-Path: <linux-pwm+bounces-8780-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFg8Dzzx+WmcFQMAu9opvQ
	(envelope-from <linux-pwm+bounces-8780-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 15:31:40 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D48AA4CE8AD
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 15:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 179BA3032DBA
	for <lists+linux-pwm@lfdr.de>; Tue,  5 May 2026 13:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E96A426EC8;
	Tue,  5 May 2026 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9CuiBRR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFC4282F2F;
	Tue,  5 May 2026 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987613; cv=none; b=Aw56n5BAZkj8w+cZ12uEdyiXGU3CKNjm/XTna35VLGDtSgbQROhCobc0qeBjtHKXiiaUUPbi7s38unq1JLJ4Jk1ZchTFucjGOnMBBRI1LBx+JaT3Btr2aet15/jMzzajmAJgLY8cmhQoQfX4FNBPoRj54/7F4ox8IaOf+5MDgKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987613; c=relaxed/simple;
	bh=AUXwHVKBn5W1eru+voELDFQxjrZF0KYACsGVpH6XKFU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzJhsAiiwNrV1+FKEp2ADq6An4/LqpfaBwEZkKHmsXCdTLcEaDXfPhUT+xT0xF776gP56i577n4Cy12P2Weq+RVAYntCfcrIz44cHVHQbWBlfADwhRPfXfTiqAFh9e3HK36SxBOpi/8Ru8V22vu9Vk4ygiywQU7UQnrOlPflswo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9CuiBRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3779BC2BCB4;
	Tue,  5 May 2026 13:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777987613;
	bh=AUXwHVKBn5W1eru+voELDFQxjrZF0KYACsGVpH6XKFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g9CuiBRRD2GQ3crVD7g2sldjPo9Gqf162pDs7Dzc6kNWFdMD16gKZ1tsnlkv1nYTu
	 g8HJOm23VOhr9H0hJ2ApihrfBbaZMGHjMGY2k1YjRB65Ml9y088R32VPo4n8qcyKb/
	 ezb1y4dmC6nw1bLetW11QXuOZjiR10IhPj9JNK2cTol7n1y+KHfknjmV63dfRhYaYN
	 lUik2uE/TUsd0MSvgw2235fA1RDxBDKFnlAoooOVJNYS5dC3vp8M98kZcrPbhY1U0K
	 FX3uE+GPh8tovtaQf+KsNHwe3ZWhvHfYHX5gPx2NhDeBEW1feuHJvxpF7L8r+KQF4V
	 clYCghsv+Vvbg==
Date: Tue, 5 May 2026 14:26:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lars-Peter Clausen
 <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
 <linux-pwm@vger.kernel.org>, "linux-gpio@vger.kernel.org"
 <linux-gpio@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v9 3/6] iio: adc: ad4691: add triggered buffer support
Message-ID: <20260505142640.49cde0ca@jic23-huawei>
In-Reply-To: <LV9PR03MB841441B282275F8F36FD12C1F7312@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
	<20260430-ad4692-multichannel-sar-adc-driver-v9-3-33e439e4fb87@analog.com>
	<afhReLCsEdaEOT_H@ashevche-desk.local>
	<LV9PR03MB841441B282275F8F36FD12C1F7312@LV9PR03MB8414.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D48AA4CE8AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8780-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,metafoo.de,analog.com,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]


> 
> > > +	for (i = 0; i < ARRAY_SIZE(ad4691_gp_names); i++) {
> > > +		irq = fwnode_irq_get_byname(dev_fwnode(dev),
> > > +					    ad4691_gp_names[i]);
> > > +		if (irq > 0)
> > > +			break;  
> > 
> > This is problematic in case the above returns EPROBE_DEFER. Can you confirm
> > it
> > may not ever happen? (Note, I don't know the answer.)
> >   
> 
> You are right, thanks for this!
I'm missing something. Why is that a problem?  Driver will return
the error and a dev_err_probe() is used so it won't print anything.
So probe will fail which is exactly what we want.

Jonathan

> 


