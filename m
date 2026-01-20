Return-Path: <linux-pwm+bounces-7968-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOv5HZzJb2mgMQAAu9opvQ
	(envelope-from <linux-pwm+bounces-7968-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 19:29:48 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 071624977D
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 19:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6ECF46C873
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 15:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD8544A72E;
	Tue, 20 Jan 2026 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="VMOwRc91"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5745244BCB8
	for <linux-pwm@vger.kernel.org>; Tue, 20 Jan 2026 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922602; cv=pass; b=ud+2D7hdyCPg0Avq60LNjo7q0Pcge0n0dq8mZ2MUMWNTIjex4amj/MdyKmWrGCf7CvcfUqtP/3LmrjQ8F1EhsiMD3ivTU38RSPC51kk2KmvvEmGfNgZrrzyz+3oP8IpdIgnnaDLQOjL7wynAt6ZDgGwCzTbWleXJPw0sucfsJQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922602; c=relaxed/simple;
	bh=GJ6wa8Te6/8EccoMRkNvLT1RYUYW61SQNJjyehv9Yt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=banEdygQ37Z7twoOxSFzUOeXv3gDRRMR0ZQE5D4IFWyVN6QNC5Ke+4BkeBujHMF1xkPzJT1lpvqrKImoIRfM6+TehnLyu5sH6z9KXv0h7BZE7wkVy2EXw+V4k9plhtMJHyBpQaNc+FVEukj1ah/omox0+vyLstkNo/KRrbyEqHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=VMOwRc91; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64471fcdef0so4449669d50.1
        for <linux-pwm@vger.kernel.org>; Tue, 20 Jan 2026 07:23:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768922599; cv=none;
        d=google.com; s=arc-20240605;
        b=a7KcQyW3shIGMS/Ru0+VqgpAP+fWCv1ndSZTZ/VGVAvDMa9nhTwwhD5eFWkkGZwkOS
         gQPfYRzLCJI5/XJyuS/ZESnl3oI5nBCHu2tTKF8fcDmADmOdaq7Ofrzvwqvv/HsfezaT
         qR3rOZgu+7Blc5EhLqgsPdNXxbHMu1+ZddP7stYZ2ohfWvL/rCFjJja+RR0C08kjlcsB
         uYSswucDPpUnb3gTq/5QCqtQ9Eob3SeMKjd8IJ9i4tZICTnnFawkUdNUdY5JaYckrEkE
         MFwK5AUatVWgGjIXXkmy+fqdBWl4oYyTvRKZpd+TLERjaJUq2EpthTsxbp/+dGHI3Pvv
         c8Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kcgJ2lf5d4h+MC2NzS3GV69WzU8S/vRED/RrE/WAmuE=;
        fh=J6ssEO2Hj3SBdieMpmYaKgU3nq5TaWtXvtt7ivZMKYo=;
        b=ZLkF/vSrKtBKIBJeU5/cM07sep+lkP9oYe2Crjbl+veCIlR2qY8XACsV1BkoGhj3ID
         Fs43MuzCR5E6WZlMetnErkOkh1Vxn3KhQpr15l0jigqCeJSRu4SJPPxUvn0w3Y0dtaVL
         HYa9Y9Wl69728DEqJ5d69I28K1z4ndIPy9+Fo7VaDxCPfIj1n3afnziR7lRNhlVg4LQu
         4gQkvd77wB81dKPHhpUygdkcGdzjQHjAcKCnSiVJkr7nls44NcQV2JPL0oDZ+2kFkoZw
         OaFI8+mn8Mr/trTkpF/zETyzN++3CQYOrjJae0jkuyn3dhDCi1VJ257TJlf78y5ymJNQ
         Vwrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1768922599; x=1769527399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcgJ2lf5d4h+MC2NzS3GV69WzU8S/vRED/RrE/WAmuE=;
        b=VMOwRc91Gn0ZVSmb9+/RugwHYz61OWR/9YnJ4dsOZDJes8uiCkQ7fqXsutsCgcFELQ
         awq/DyRah3RTpRkUZNxS+zrjnVyVLgxkloaqEu1MkBMEr+FxYW4Pow3T3VHTw8jG4lGy
         OFLW7dmP3SRM8GsmET0GIXDX79V1DETb7H9fBoOtJnk3Hy/ZIVW0tHTEZBscKTgsnPLW
         QyK0Mx+33Gkh2BlImoL2aC/1taLoqAjASccNxDD1AxiWsZd85Ipzb4+vdkmsmU3tgAPV
         aTmR4QAb0dtw5WOc/1TcUY3mohsmIFY0WPp5dWcMOYBfFzVhMXAxfjLvNfE7T/wy4iE8
         F+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768922599; x=1769527399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kcgJ2lf5d4h+MC2NzS3GV69WzU8S/vRED/RrE/WAmuE=;
        b=Re53JYGyBDq0oxcHrX7jxQStbuxsWuQwJIb1/A9a/Dd4ReSlp1xqJCL/tch3oIB03Y
         uLLF95zQAouclY3i6Y61D0qZxNcGM6Ko/XyfH8Epu9FUITb0hteFqIDxbDVtuw2jLK0f
         FKp3vh2aFsDlDgD/I2MnKigNBOSJUaWal369appD37KTiiZmBqEcu9sC+QiF09z0AF9+
         iEUdygXJH/R2RtfcWhVURNFHxLm0vilHXpVrzlGVPJC5Uzh7/0e8oCY0bRCpLMA/yojq
         3xiPAf6o8ebVd+aa+SUlDTdxJ946nTeEayMAHTWkBAHrwm+FB8GA9cqie9SuZpp2xVmg
         LZ0w==
X-Forwarded-Encrypted: i=1; AJvYcCXEy192XpYxmfOsOqbHgTyPmKsTSVi9OVpxN/cK+WpDq5waF1NmAEMn0I1TA4aJiJv+Ji/JjGNgiiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWz7iDQA+XhG+rU9SPY47ak2iP3AdIpaf2hz2JZYiJbfzKahi+
	+KDIEwLz/TwmxjL1DU9i24Bz7N8WWlaZkuSJyOtXf0QzDeKqD2yjJ0xo69t+BU/GPfO4XMDi3zB
	/bPGcuY4X8zE5RzdSvTzdCcZO8efFdhF6yIIX1/yy3w==
X-Gm-Gg: AZuq6aIweudxdh3jAYjk/RLfW2yOlAYVypuENwXhBkMfW9MZHrrdenlSjrl03jZFj9U
	Tw2GSM4/4LaYj6U71KldkcqF0ZjLDkwPKGk09MF32MBEKOgpr8p4H+U5aCcO6Oa6+/ea5FAUQxR
	O6VAVzsZEFuh9CNbrgbpy/9pzj7RyJUduBYsBfYSNXJZDoQB3AQ+6e/qlMhoXfStM6M/InWaL4u
	4Be9Rm18qm1I+JV/8GguSiMQQ2yMstI8Edst0dPT365ur33MHtXbI/Qv31WKcFUU97f1O7/G+Um
	NhPgO9MicSzUh2dxB+Qv4/9kGX8=
X-Received: by 2002:a05:690c:f82:b0:78f:bc2b:83f5 with SMTP id
 00721157ae682-7940a11fa0bmr36632337b3.20.1768922599034; Tue, 20 Jan 2026
 07:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104194224.41245-1-marek.vasut+renesas@mailbox.org>
 <x25kxyh4t4u6c3ilj7nxp6sywab5dsar46b2foesrwfux2l4b2@d5iwqqcpdhlm>
 <797047eb-e422-4a8b-80eb-ab130066c1d7@mailbox.org> <xsjwvmlqclctnf6dgwyuoi7zits27is2s7r7taprb2w2lhsf7i@uiljd7o3ivbk>
 <855e5015-98c8-48f6-9320-ca8163591940@mailbox.org> <CAPY8ntACxpoZV2_8-9028AaA1mBScUOuK06a6x-XwdSeobiauw@mail.gmail.com>
 <6f2b7a15-5d43-4a63-b374-6a452d1ccba7@mailbox.org>
In-Reply-To: <6f2b7a15-5d43-4a63-b374-6a452d1ccba7@mailbox.org>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 20 Jan 2026 15:23:03 +0000
X-Gm-Features: AZwV_QjC1UKdlMv8KhHRBZLyu8sa4Tueb3-nr6Za0teRv6fYsygE6N08OBhX_PM
Message-ID: <CAPY8ntD0Z39aC3j+mpZ-9uF3AysHFBNo4ckuexKRuuLUk+8TcA@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-7968-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[raspberrypi.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.stevenson@raspberrypi.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[raspberrypi.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid,mailbox.org:email,raspberrypi.com:dkim]
X-Rspamd-Queue-Id: 071624977D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026 at 14:55, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 1/20/26 3:41 PM, Dave Stevenson wrote:
>
> Hello Dave,
>
> >>> On Thu, Jan 15, 2026 at 02:14:15PM +0100, Marek Vasut wrote:
> >>>> On 1/15/26 11:12 AM, Uwe Kleine-K=C3=B6nig wrote:
> >>>>> On Sun, Jan 04, 2026 at 08:41:43PM +0100, Marek Vasut wrote:
> >>>>>> -  struct regmap *regmap =3D pwmchip_get_drvdata(chip);
> >>>>>> -  unsigned int duty;
> >>>>>> +  u8 *wfhw =3D _wfhw;
> >>>>>> +
> >>>>>> +  if (wf->duty_length_ns > wf->period_length_ns)
> >>>>>> +          *wfhw =3D PWM_BL_MASK;
> >>>>>> +  else
> >>>>>> +          *wfhw =3D mul_u64_u64_div_u64(wf->duty_length_ns, PWM_B=
L_MASK, wf->period_length_ns);
> >>>>>
> >>>>> This is wrong. There was already a discussion about this in reply t=
o v2.
> >>>>> I'll discard this patch from my queue and continue the v2 thread.
> >>>>
> >>>> Instead of resuscitating the old thread, could you please tell me ho=
w to
> >>>> make the conversion, so it won't break with existing bindings and th=
e result
> >>>> would work as well as the current code ?
> >>>
> >>> the only way you can do this correctly is to measure or research the
> >>> actual period length of the device. As this seems hard, the function =
I
> >>> suggested in v2 works for me, too.
> >>
> >> Sadly, that does not work on the board I use , which is the one below.
> >>
> >> I was also hoping that Dave might have some input on the PWM frequency
> >> of this display.
> >
> > Sorry, I don't have that information, which is part of the reason why
> > I originally wrote the driver as a backlight driver rather than PWM.
> Is there someone you can ask by any chance? Is this hardware made by
> waveshare ? Maybe they would know ?

It's made by a 3rd party we work with. It's not Waveshare.
I can ask the question, although I don't really see the gain in having
to insert pwm-backlight into the chain when you don't have full
control over the PWM device.

  Dave

