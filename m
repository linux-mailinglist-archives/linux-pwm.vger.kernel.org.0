Return-Path: <linux-pwm+bounces-8166-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMBrIjeVoGmvkwQAu9opvQ
	(envelope-from <linux-pwm+bounces-8166-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Feb 2026 19:47:19 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 491EC1ADF60
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Feb 2026 19:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E3A93001FEB
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Feb 2026 18:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1FB426D15;
	Thu, 26 Feb 2026 18:37:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF9035A380;
	Thu, 26 Feb 2026 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772131020; cv=none; b=twnGu3WPQtUGHlFYx0He09MzAtnaKgmqdVSuZ6/ifL0/GKLAQRBhkmhL9eZ6I/kWCn+TDX/TAZDqOivj7yxu6BhhSMVxiyQCkL0IMbZi2B6E2UAbawfOUj5JzfCz/AALBpRD0ZT1sVcbIO1k2meHSbTS4ZVaA/ycWOA5I6p0mJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772131020; c=relaxed/simple;
	bh=sRRUHQ8nku8SZqHBNBcQg7fQm60OhaMpWK267Bn6/b4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=M5RTBlYcQQQ8315SmPIOwHnUAmGK0tgKCTE+6S1N62s7S3Kot/Zf1C/jIS1Ik7QrBQEvYehbW/VmQGStDE3MvFwT1kjXbyiGvYk9OlHzNaxcmpku47b7ncZExYG1r6/86C9mc7B+SgidU6ILqxq7313dXgERPhkMvCo+E/lcYrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id BE9CE298580;
	Thu, 26 Feb 2026 19:36:45 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id MaL9rZlZo95P; Thu, 26 Feb 2026 19:36:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2EF7B298599;
	Thu, 26 Feb 2026 19:36:45 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id L2wQ0dmSl527; Thu, 26 Feb 2026 19:36:45 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id EA45C298580;
	Thu, 26 Feb 2026 19:36:44 +0100 (CET)
Date: Thu, 26 Feb 2026 19:36:44 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org, 
	linux-hwmon <linux-hwmon@vger.kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, 
	julian friedrich <julian.friedrich@frequentis.com>
Message-ID: <1212284023.1388.1772131004601.JavaMail.zimbra@nod.at>
In-Reply-To: <aaCHc4q0I8Az7hpx@monoceros>
References: <20260225125159.20822-1-richard@nod.at> <aaCHc4q0I8Az7hpx@monoceros>
Subject: Re: [PATCH] [RFC] hwmon: nct6775: Register fan PWMs as PWM chip
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF147 (Linux)/8.8.12_GA_3809)
Thread-Topic: hwmon: nct6775: Register fan PWMs as PWM chip
Thread-Index: a2FkoSPj2isBvD2uWv71j3ga/gQkdA==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8166-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[nod.at];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-pwm];
	FROM_NEQ_ENVFROM(0.00)[richard@nod.at,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nod.at:mid]
X-Rspamd-Queue-Id: 491EC1ADF60
X-Rspamd-Action: no action

Hello Uwe,

----- Urspr=C3=BCngliche Mail -----
> Von: "Uwe Kleine-K=C3=B6nig" <ukleinek@kernel.org>
>> +=09struct nct6775_data *data =3D pwmchip_get_drvdata(chip);
>> +=09const u8 *wfhw =3D _wfhw;
>> +
>> +=09if (get_pwm_period(data, pwm->hwpwm, &wf->period_length_ns))
>> +=09=09return 1;
>=20
> That looks wrong. In principle nct6775_pwm_round_waveform_fromhw()
> doesn't depend on hardware state. It's supposed to just convert the
> settings stored in _wfhw to wf. If you know that some things are
> constant during the lifetime of the PWM and you read those from
> hardware, return a proper error code, not 1.

I see. Since the frequency is never changed by the driver we could
read it while probing and use here the cached value.

> Rounding down wf->period_length_ns is fine, so this must be:
>=20
>=09if (wf->period_length_ns < cur_period)
>=09=09return 1;

But then the period is no longer fixed and something larger than supported
can get configured. Smaller values get caught, though.

e.g.
root@fedora:/sys/class/pwm/pwmchip0/pwm2# cat period=20
43243
root@fedora:/sys/class/pwm/pwmchip0/pwm2# echo 43200 > period=20
bash: echo: write error: Invalid argument
root@fedora:/sys/class/pwm/pwmchip0/pwm2# echo 50000 > period=20
root@fedora:/sys/class/pwm/pwmchip0/pwm2# echo $?
0

Thanks,
//richard

