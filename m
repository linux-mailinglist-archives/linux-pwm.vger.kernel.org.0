Return-Path: <linux-pwm+bounces-7966-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LdlMjiub2k7GgAAu9opvQ
	(envelope-from <linux-pwm+bounces-7966-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 17:32:56 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCA1479FE
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 17:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9AB357282B8
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 14:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA1944DB65;
	Tue, 20 Jan 2026 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="YBpD+GcP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D9744D6B5
	for <linux-pwm@vger.kernel.org>; Tue, 20 Jan 2026 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768920104; cv=pass; b=bR5mGtq85r5/UFpte2xIUVXRWmURQ+nfHyPiVLg5ULrwGeOGnxYP0Unte9+1Zna2ievlekbMeCzAiQU2s9zByfglVJVJRxyRBBL8GYDj9VuYbN5tjdKm9T2c3X/xfPosvMsLprzlr5w2IbsxhrxnfjWJem90JRH++fTrw8xVpt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768920104; c=relaxed/simple;
	bh=FnhOZFFzbVVzIYVojcDRn86X+5qaUjeiK0QPjcy1S1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTrJ+ECMlnarN1HL8Hlf6vvAKUJgwKv4wB/1wRedfthKXCcKbr0K9Ysl0+oUwHmjA/XrGcWz1QwEP7XSZG7ZG/559AEILqTHSnmJfHv3w48v9FgxZyerVX5uU1hM9rrzciRDjHSryH57A5P/TsN8dWvr16Nrww0MLS7diLhvi2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=YBpD+GcP; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-644715aad1aso6106490d50.0
        for <linux-pwm@vger.kernel.org>; Tue, 20 Jan 2026 06:41:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768920102; cv=none;
        d=google.com; s=arc-20240605;
        b=B0P0LSZML8hGg6MDpu3m259K3RuqmUzBQ3kL+wP/sxqSdgnKKgxMleSAlkT+nmOoah
         Qf8M6Vob+y8Ml0wYnT8U+NFjZK3dRB/yf4gy+yvRmdZEWJTxBDEnY6kgGq3e2KUXplhf
         gCG/HqDM/3UOqDBly7iRhn2jPbNuhMHpcIPFXAYV+Ln+UNXMst/Pr6khk2+30w8L+4jq
         RtBoikJm0n6u+SJd6I1noDJFAzphYOF9YiuZ4F9M6+nsceIiPHxDD7UdA3YZHjwC8J+S
         agWhOPOkG1pfkejaZ7g/eAMYxXlViURzuRhfRFmSlo23rK95B5hzNGE5zkfCYjmRIwE9
         Ke9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dwvfsH0axGRKvYYmd5lZV7RDUOkXm5uPzF6BS5XKPv8=;
        fh=0XWa2nmUeJQehQRbPvVC9Gd2eEWEf3Yqj8ZvraeDM60=;
        b=i/cGFpR8WOaR3qNYgrbsGkB+cKvQfxnCiAHaNows2OM8no3b/OVXMAUdDLWjHrD7j2
         UFcNp3Z1I5EMAjxgTOPnTaQx3Jql1cVdawX87R7Xgxikgg41A3A4eG1bddfgFiff/ooz
         WwQyg1x3A+hBcKt2E80GCPJXJoz5UtsLE5oli1cJwW/YwvJuj3KH4hNPnGxCbtHimk68
         R1LlvkYWD9cr657VeIWpP42o+kaszqapuD52Ym2a1q5nqqbCJSTu0jxs/xH/d5mFrNd4
         X+R8JYgFgBdwnzAKHZyNXXcIN7KUIfOPSQDLR18cUGJjwBCKwRYRnGJENWV1I+zLQxss
         YAAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1768920102; x=1769524902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwvfsH0axGRKvYYmd5lZV7RDUOkXm5uPzF6BS5XKPv8=;
        b=YBpD+GcPIZGmpM77MQWo2SYT09ZichSf9AZfPJ3fiNmOPpElQnzlnyVc82GL79ncRM
         5GhQUB0ONcLgHfvzcYVvbKiqK/HGflwf5S6khiRGg4bzbuQ428niLD9hms2YtuwxnGHA
         0Imm0n7dzxzdrjjd29S+ISHoB9Kpne+NUk9jjC6WwsBrkvhflT+z1nV6Mg8GUaBio09x
         7XXNyoGEO36+LrnXojDSns0hLTkPu/4qMNPRFOcqh9p7kfsx5dUOOFRKyX1Kmz+Jdz0i
         uuTAl2VBCVEfJSs7eOEGLEhyshM+AgJvCZ1homBsJr0bItWgaSZkCjgnbA1VxESL6sUi
         VCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768920102; x=1769524902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dwvfsH0axGRKvYYmd5lZV7RDUOkXm5uPzF6BS5XKPv8=;
        b=hTo5yHkDhl1R5USg+SI/8ssPOCDirzf9hfoXnnE01AhuIaqKHphehR1aBWdefk2Tba
         YKw4RTsVv9Uwon1tofPg5gYnaGa6BbZR7btt8Y5zb57JN6Kqj98emMehi/jJxj6zdkkA
         2E3oQ1T/KKLGQiufm/sz8L/JjY4no+NqRzJxKB0EvcU2/3tasqOU3tPRFsc3xHLq+Nz0
         kO6sbuBtarlYq0dpS1GH8zdcJ5dGff+vZIyrk6afehrz5XQBTFmnHX7SQNDGuOG9kkN1
         IPrWxSvfBlsOsbou2GyUFjNKl5qNcgkm5WFQ4q9b9tYwSF7eJfZ/l66oW1Its3jelQTm
         zHNA==
X-Forwarded-Encrypted: i=1; AJvYcCUCwcYwr1Fwuc+WbmHzaoagE+OJ5gztCyD4R1KakO1sAYnAyWZsb+BJscQvoya3/OnxQprH2+C0pNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5W/aLmx2yNwxg2XXN7/DoqQ6XJDPS2D2uOmOdvxE4oSvjU0FM
	ZShPHoEUB1hoB3N5ob4k6huWYCYWkgK2S1cTtSBVmFfxLS+M05KHGAS4kb2VP6/Aig9stZr45as
	ZTR0OLrLrVpNgK8csJRxJ67/8/xC7TsIOQvE0pJvMRg==
X-Gm-Gg: AZuq6aJlPizuKXuVNwzXjOcL604DFFhguye1M00BAZoGkIVfii7TYeU9iKvRRtBxgHW
	gqKsS9E27m5Ha723Phsu/mD9POb9pShkBsEDx/TQ7pjUMR5F60GaHQZp0vHGdKEzuwPVFqUHha1
	sttgB6NLNlFWX2HbYps5QwduK5/hSqNLEDHXm94V/RemUNC6K2H7IVEnkGw9QxOud8inIVt91sC
	Jyu2RFd+h9b2kJqtAO/GJd28eKYYGeZmgGrwO5ebodwGiPLPGgtLKFOSMJlyvwUbyZKdWlnaV/q
	7tfvO1i/USJwZCNCAhuSJAwgy2I=
X-Received: by 2002:a05:690e:1c1c:b0:644:50c7:a50a with SMTP id
 956f58d0204a3-6490a67e8f3mr13021072d50.32.1768920101695; Tue, 20 Jan 2026
 06:41:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104194224.41245-1-marek.vasut+renesas@mailbox.org>
 <x25kxyh4t4u6c3ilj7nxp6sywab5dsar46b2foesrwfux2l4b2@d5iwqqcpdhlm>
 <797047eb-e422-4a8b-80eb-ab130066c1d7@mailbox.org> <xsjwvmlqclctnf6dgwyuoi7zits27is2s7r7taprb2w2lhsf7i@uiljd7o3ivbk>
 <855e5015-98c8-48f6-9320-ca8163591940@mailbox.org>
In-Reply-To: <855e5015-98c8-48f6-9320-ca8163591940@mailbox.org>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 20 Jan 2026 14:41:25 +0000
X-Gm-Features: AZwV_QjWaUa_a7faZZuf7zJEt6ishs_xbFjuO7jz3JnzKJFtb2ov21CgCG1WR4M
Message-ID: <CAPY8ntACxpoZV2_8-9028AaA1mBScUOuK06a6x-XwdSeobiauw@mail.gmail.com>
Subject: Re: [PATCH v3] regulator: rpi-panel-v2: Convert to new PWM waveform ops
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-pwm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[raspberrypi.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-7966-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[raspberrypi.com,reject];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[raspberrypi.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.stevenson@raspberrypi.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.45:email];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,mailbox.org:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 4DCA1479FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Marek

On Tue, 20 Jan 2026 at 13:50, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 1/15/26 5:37 PM, Uwe Kleine-K=C3=B6nig wrote:
>
> Hello Uwe,
>
> > On Thu, Jan 15, 2026 at 02:14:15PM +0100, Marek Vasut wrote:
> >> On 1/15/26 11:12 AM, Uwe Kleine-K=C3=B6nig wrote:
> >>> On Sun, Jan 04, 2026 at 08:41:43PM +0100, Marek Vasut wrote:
> >>>> -  struct regmap *regmap =3D pwmchip_get_drvdata(chip);
> >>>> -  unsigned int duty;
> >>>> +  u8 *wfhw =3D _wfhw;
> >>>> +
> >>>> +  if (wf->duty_length_ns > wf->period_length_ns)
> >>>> +          *wfhw =3D PWM_BL_MASK;
> >>>> +  else
> >>>> +          *wfhw =3D mul_u64_u64_div_u64(wf->duty_length_ns, PWM_BL_=
MASK, wf->period_length_ns);
> >>>
> >>> This is wrong. There was already a discussion about this in reply to =
v2.
> >>> I'll discard this patch from my queue and continue the v2 thread.
> >>
> >> Instead of resuscitating the old thread, could you please tell me how =
to
> >> make the conversion, so it won't break with existing bindings and the =
result
> >> would work as well as the current code ?
> >
> > the only way you can do this correctly is to measure or research the
> > actual period length of the device. As this seems hard, the function I
> > suggested in v2 works for me, too.
>
> Sadly, that does not work on the board I use , which is the one below.
>
> I was also hoping that Dave might have some input on the PWM frequency
> of this display.

Sorry, I don't have that information, which is part of the reason why
I originally wrote the driver as a backlight driver rather than PWM.

  Dave

> > The specified binding is unaffected by that. The only dts I found using
> > this device
> > (arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk-rpi-display-2.dtsi)
> > has
> >
> >       backlight {
> >               compatible =3D "pwm-backlight";
> >               pwms =3D <&mcu 0 255 0>;
> >       };
> >
> >       mcu: gpio@45 {
> >                  compatible =3D "raspberrypi,touchscreen-panel-regulato=
r-v2";
> >               ...
> >       };
> >
> > . Given that the dt specifies something made up and the driver was
> > written in a way that is wrong but does the right thing in combination
> > with the made up .dts, you cannot fix the driver to be a correct PWM
> > driver without having to adapt the invented values in the .dts, too.
>
> I think this is what this V3 does. Would that be an option here ?
>
> > (An option would be to adapt the pwm-backlight driver to ignore the
> > provided period, but I think that isn't sensible and badly affects many
> > other machines that have a working PWM driver. Or assume the PWM's
> > period is 255 ns which is probably wrong, but so is 100 ms (the latter
> > probably to a lesser extend).)
> >
> > Maybe the lesson to take away here is: if a driver implements a PWM, Cc=
:
> > the linux-pwm list and the pwm maintainer on the submission. And let me
> > point out that even get-maintainers.pl knows about that:
> >
> >       $ git format-patch -1 --stdout d49305862fdc4d9ff1b1093b4ed7d8e0cb=
9971b4 | scripts/get_maintainer.pl
> >       ...
> >       "Uwe Kleine-K=C3=B6nig" <ukleinek@kernel.org> (maintainer:PWM SUB=
SYSTEM:Keyword:pwm_(config|apply_might_sleep|apply_atomic|ops))
> >       ...
> >       linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM:Keyword:pwm_(c=
onfig|apply_might_sleep|apply_atomic|ops))
> >       ...
> I do use get_maintainer to CC people when sending patches, hmmmm.

