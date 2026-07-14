Return-Path: <linux-pwm+bounces-9719-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MOJyMH8oVmo60QAAu9opvQ
	(envelope-from <linux-pwm+bounces-9719-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 14:15:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE03754614
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 14:15:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9719-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9719-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE0BE300ECBA
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 12:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EDD3B42FD;
	Tue, 14 Jul 2026 12:12:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DFC3B38A1;
	Tue, 14 Jul 2026 12:12:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031168; cv=none; b=VfIkq86jKDj8RJiu4PnnBZjyvtI77pz+XUiFtYGYuDAFVpqSoMOp08YBE6CjEbKl/e+PUgCwdACFo4JZKwRixmy4Y1nQREN06PcMuBVDLAs8AMI4/mh0q5LKr/CF9odMbIiWoD+EUlqse3KWVshfLwIWJFSKRjZq+iyNO86+hXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031168; c=relaxed/simple;
	bh=n3bcQL69HI0lQ9uE3jKhUFx/rTxQ1Sd23ZpM2ZlhR10=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d3gbyfA2fUufOPs4i8HD+dysc8EeiZZF7t0Q2w9s4CB3g+mGyB0X3yYG3GG1jPpYrIZEg1VrSxcu1eN0a/XMAsLMfTz0cdLSIa/FxM2i/6HY5xlIVJI3H6bZB3YRh58VlLhKwXOcYKdemOJVpCkoM6j8seTauRDVEGdKVk9q0GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EFC502021FA;
	Tue, 14 Jul 2026 14:12:39 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wjc07-001ljJ-2u;
	Tue, 14 Jul 2026 14:12:39 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wjc06-00000000C8G-2azB;
	Tue, 14 Jul 2026 14:12:38 +0200
Message-ID: <cf1bd92a11661c99802867581b599617ef69f503.camel@pengutronix.de>
Subject: Re: [PATCH v1 4/6] pwm: tegra: Simplify using
 devm_reset_control_get_exclusive_deasserted()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Thierry
 Reding	 <thierry.reding@kernel.org>, Jonathan Hunter
 <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
Date: Tue, 14 Jul 2026 14:12:38 +0200
In-Reply-To: <1f12ae7f9479aa910fcaf066fae82c7b7cb89073.1784030076.git.ukleinek@kernel.org>
References: <cover.1784030076.git.ukleinek@kernel.org>
	 <1f12ae7f9479aa910fcaf066fae82c7b7cb89073.1784030076.git.ukleinek@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9719-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:thierry.reding@kernel.org,m:jonathanh@nvidia.com,m:mperttunen@nvidia.com,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[p.zabel@pengutronix.de,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p.zabel@pengutronix.de,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:from_mime,pengutronix.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3AE03754614

On Di, 2026-07-14 at 14:02 +0200, Uwe Kleine-K=C3=B6nig wrote:
> This function ensures the reset is already deasserted at probe time and
> asserted at unbind. So the remove function and the error paths in the
> probe function can be simplified accordingly.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> ---
>  drivers/pwm/pwm-tegra.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index e99e1c5b18c3..d7f4baa4cd9b 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -108,7 +108,6 @@ struct tegra_pwm_soc {
> =20
>  struct tegra_pwm_chip {
>  	struct clk *clk;
> -	struct reset_control*rst;
> =20
>  	unsigned long clk_rate;
>  	unsigned long min_period_ns;
> @@ -319,6 +318,7 @@ static int tegra_pwm_probe(struct platform_device *pd=
ev)
>  	struct device *dev =3D &pdev->dev;
>  	struct pwm_chip *chip;
>  	struct tegra_pwm_chip *pc;
> +	struct reset_control*rst;

You could use this opportunity to add a space between reset_control and
*rst.

>  	const struct tegra_pwm_soc *soc;
>  	int ret;
> =20
> @@ -391,20 +391,17 @@ static int tegra_pwm_probe(struct platform_device *=
pdev)
>  	pc->min_period_ns =3D
>  	    (NSEC_PER_SEC / (pc->clk_rate / TEGRA_PWM_DEPTH)) + 1;
> =20
> -	pc->rst =3D devm_reset_control_get_exclusive(dev, "pwm");
> -	if (IS_ERR(pc->rst)) {
> -		ret =3D dev_err_probe(dev, PTR_ERR(pc->rst), "Failed to get reset cont=
rol\n");
> +	rst =3D devm_reset_control_get_exclusive_deasserted(dev, "pwm");
> +	if (IS_ERR(rst)) {
> +		ret =3D dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset control\=
n");
>  		goto put_pm;
>  	}
> =20
> -	reset_control_deassert(pc->rst);
> -
>  	chip->ops =3D &tegra_pwm_ops;
> =20
>  	ret =3D pwmchip_add(chip);
>  	if (ret < 0) {
>  		dev_err_probe(dev, ret, "Adding pwmchip failed\n");
> -		reset_control_assert(pc->rst);

With this change, pm_runtime_put_sync_suspend() and
pm_runtime_force_suspend() are called before the reset control is
asserted again in the error case. Is this safe?

regards
Philipp

