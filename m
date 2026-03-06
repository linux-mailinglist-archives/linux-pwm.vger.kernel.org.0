Return-Path: <linux-pwm+bounces-8206-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGcKJkkQq2kRZwEAu9opvQ
	(envelope-from <linux-pwm+bounces-8206-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 06 Mar 2026 18:35:05 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EB122645E
	for <lists+linux-pwm@lfdr.de>; Fri, 06 Mar 2026 18:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6780D30439DC
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Mar 2026 17:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CDB3F0775;
	Fri,  6 Mar 2026 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QGLQh2OH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505E13ED10E;
	Fri,  6 Mar 2026 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772818239; cv=none; b=PPB1hd0Z9fVM9OdBc0Bq8qgUEaPyegY6Ysu6bYfFg1Zh6sPN66eFV7tSXRSIqLgXJtNrezqD4LVWbVBH/1CdkAwb3GsMn9nBiC73q4cfRSjZywMBgCxJDu6TIsX3zraiVFaC7LxemGfyZ46H0BFCmpqYYN/PSQ07DNANrfz/tOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772818239; c=relaxed/simple;
	bh=iirW3cdvIjMtLct2LQyILKWs+AkDGPwYr9osifxyzJQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Ge+/8EQd9pijYto7QDo2Pxovhq5qhy8mbKLrznc0k9z9Lc4WNHRYV52G1cOK3OBaDEhM94Dxjzz1WXt2BmFYEcJDypjEeCk7Kcbup+QosUuI615OO8rHpBL+6SfEtXEpPOgixmOEet/YdqX+reXWZZxI6FrMrR6avJlpfMiyfZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QGLQh2OH; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1772818234; x=1773423034; i=markus.elfring@web.de;
	bh=aCvQlpXDz260BMbgYOCBaTLrk1IVxt/fe+l+8eDa07Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QGLQh2OH6Rh5r7Ex4NTinAPjbRk0y+T7lEstWDiKPsLbb9KUrxD3Pg3nYpZRhaH1
	 sZZ4lCJnrlb4ymw+QrxeI5MgXNDlBfsKufzocyTpk0NjEuWXjBqnaI2XZnLmVWnBl
	 WOLDIDLoAP50+QR5DPNshU3LuqPSFEq6Tx4m7A11AYEldPpPTUQx64p3WWQKduhnz
	 SxlB80bgMGC9PwiC2Tt/iG08i6lI4hRhDB9VratE6aoWhd6LBGovss3sdyk2GrPG2
	 1CHV+/gJTnHhOl58++UuW8r95A1yCqCGD2dERX0wf5CtMx0UbQlbLob44z9AdV8b9
	 pR9Qmzf+RH76DlKn9w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7Nig-1w1rr4224i-003kHq; Fri, 06
 Mar 2026 18:30:34 +0100
Message-ID: <7f2787b1-c176-4c30-b1c0-211461c93673@web.de>
Date: Fri, 6 Mar 2026 18:30:25 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Radu Sabau <radu.sabau@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Linus Walleij <linusw@kernel.org>, Mark Brown <broonie@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260305-ad4692-multichannel-sar-adc-driver-v1-2-336229a8dcc7@analog.com>
Subject: Re: [PATCH 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260305-ad4692-multichannel-sar-adc-driver-v1-2-336229a8dcc7@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hqobFGqgeFmUhj8+QTtFaZhtp+EHaNRODlPpFs84hdCGIm3Yhjn
 o4gqFFeLizyI3bnVGdarAApggE2VPfusplml0n7t+5ecGSAxMCccB/W5LDRv9P/ycHhShZE
 u65pfU2gntVJ1VZytX2k6dTKGi8+XktK8BAJbOPSGLAFEqhlXWmcEd2/dxSyj8yFvnPSXQB
 oJtAQ4fsR56rdBgOdBoGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0FqIr29Ofqk=;2c8394JyzZhP5s0weGhz7AVT6vn
 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
 eYcKZHig=
X-Rspamd-Queue-Id: E7EB122645E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8206-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[analog.com,vger.kernel.org,kernel.org,baylibre.com,metafoo.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	NEURAL_HAM(-0.00)[-0.909];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

=E2=80=A6
> +++ b/drivers/iio/adc/ad4691.c
> @@ -0,0 +1,1196 @@
=E2=80=A6
> +static int ad4691_reg_access(struct iio_dev *indio_dev, unsigned int re=
g,
> +			     unsigned int writeval, unsigned int *readval)
> +{
=E2=80=A6
> +	mutex_lock(&st->lock);
> +	if (readval) {
=E2=80=A6
> +	ret =3D regmap_write(st->regmap, reg, writeval);
> +
> +mutex_unlock:
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&st->lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v7.0-rc1/source/include/linux/mutex.h#L25=
3

Regards,
Markus

