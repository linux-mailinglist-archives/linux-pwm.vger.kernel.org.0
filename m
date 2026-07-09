Return-Path: <linux-pwm+bounces-9652-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aFbgAI9OT2omeAIAu9opvQ
	(envelope-from <linux-pwm+bounces-9652-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:32:31 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E86772DBC7
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:32:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=T0XHF3uE;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9652-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9652-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4893A30166CA
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 07:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB1A439350;
	Thu,  9 Jul 2026 07:30:06 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5193DE445
	for <linux-pwm@vger.kernel.org>; Thu,  9 Jul 2026 07:30:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582205; cv=pass; b=oKcFRA8LyV/faAJ4t0HgFfEn+SGpWy8AwatTVCtq3CQRYlomL2/6rZKmTB++RlkewY/+KFoNXc3ibNXtSvPOk6uN5FT8YKHXwx55I4AiF30hcVJgKM1mu3JmNSDyJlyDw68JzhG4lJ/9eYQaeMdhXQFj9f9lc7F+84gkKBiLxBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582205; c=relaxed/simple;
	bh=Rtt03BEIARHUbT0CoEo4Sdv6ibTrcN65HIzaLWL9q5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+vcgzToqHow83K/Gq6e8c5uT6ZyCIreubQrubBgt92N3dOdiQHH9ruRBWjonZ4KUMoOQsJ/1YXE0mhgHsEbvZM+kClOBaqBe04cTCkRNAE8ihI+DK7qWkV3r7e91CeBSrvT8zhn9u1ZIRfOzxWRvisxII+Wa52B0kCIteVOh3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0XHF3uE; arc=pass smtp.client-ip=209.85.167.42
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aeb6d00883so1331198e87.1
        for <linux-pwm@vger.kernel.org>; Thu, 09 Jul 2026 00:30:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783582203; cv=none;
        d=google.com; s=arc-20260327;
        b=KsKU/vG4RRM7cvJ9L5godxqaGbg/n1vvoRzp7PqJMxw7UtCcXw99nA/qw4etYtgyU0
         Q7EAzofBjZCHT8DCqvvJ7453vQWjWvIGh8w5x5zQL5HAygMR/dSw50mJRexUcLeOxCFm
         O20ZE6sGgh2AWCbq6C/YAle7OPsdHHcfwIs5IX53SvwxmSTX8LfNOzI4NFjms4dtHrid
         a1PCPEl+qIwfO6JcVB/BkTqE4x42Ri5twRR/SI0eOZ6QH1XnKPoLW3Nj4Oo/UJPdY4bw
         1Rk4rEno2rw5Oe1PQg332Glrit1thyTvY5PxwfSRBySZID5vK7HwGhjClm/yBeMKdTc0
         KGYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rtt03BEIARHUbT0CoEo4Sdv6ibTrcN65HIzaLWL9q5c=;
        fh=DudfR0AaGKWEc6IMZybKnhGj2wmVcozaWnkmVSREE8M=;
        b=M5t8AMrzFml73FrXf0lDGTVvCBxQPYOn3U/P0v6vuYN70xqG3lrMBTUfY62XhsqlCf
         RZl7WoNL04Xr+cTNH9294bMt1V23e88Ja1OigsG1jUjUfMJSNJA+q+Cc5DXDnbw2MIkF
         A9+bbiL2tLtXvhoZ63jrsBzBC1mtQVhRX1Hrolzq94jB5EFq4zRAOZ76LxYDExjeeWH9
         Ljn5HZX3nrVApWJFhpk2WAEoMSvJyDFu5HfGVOwZ4Tc+m8Q79BMwbrsONUu1XEsVqf5B
         bIvabL7zee1+edTrAqDR3OX7ImJH+02F4cVGE2ErMZxzD61/TPPdso4a9+0y2UdNxp9G
         Gasg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783582203; x=1784187003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rtt03BEIARHUbT0CoEo4Sdv6ibTrcN65HIzaLWL9q5c=;
        b=T0XHF3uEAxTt3Jbulw5hLWUKz8B1Hm+h1uUPmKoK74SWeEA4fzAS0PMKsQqUL+d52K
         SPjY93taoqvbysUCFVTZYHV0TznbztkebxrUIwbCNO06fN/EYN6zvd1xFpmAKADcM56A
         WuYzHxjmVAZvKmzbYcPUNn9zxBAJh/KQYuUpebcdIr4ii6rkzK5mfeYM5FNkO+hndClb
         CDNhRgiGEI62rCJIEvuoR6BIKjLTT5UC59IJHbTu4zcsFAvhEz8+MoaYL95LX8vxDRO6
         qSZNC3sumsRqSQOPsLVa35IjYGqJC5eTUOtpkq5IQi8FZWYlxxjpNnOz6bGgdDXzeBjx
         Ir8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783582203; x=1784187003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rtt03BEIARHUbT0CoEo4Sdv6ibTrcN65HIzaLWL9q5c=;
        b=GyHyr6PrR9W7I/d1a/UIw/rravTP7El7MRtMtG4KI5NjQqfUrWtQ2zNcwhKjmSX1tU
         jhVJ27thR/CdyxE0esiGEFjq3Eb2uV1mxlkbsgqgJWypypQO6OgflL19Wnha5cEyAOiv
         68DDOjK41k0fu9gnngB1SiZdbKsUvNL8FcXdVozx0ltw49uPKBVcDBtnP5VnCd/Gvpyr
         6vrtKd24Og6Ek5eNPQBz1D49jKaV+bdSz9UVFpxz5QpRbBjYSfYXOKBHLsqFWXdaUvei
         bVPuCVFM3jqRbNqCt1uDunlQZnk4Hf9i4PgTFNQlaot/8EYoJr+ErMZGkZX/0WyRwvlw
         ZA6Q==
X-Forwarded-Encrypted: i=1; AHgh+Rog4YGus+1TflTOBR/k1hw53FM0k15t8axQufNh/6ANRv6XH/NUpesyLGRqmjUvEXe6cBffRg49wJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQOpkv9vOR0riY/+3YjJKUWB27yZQvrHcap4aPCUUmnC1T1IwS
	cBTAbsMiUdtJZq71SyZDGh8nnLxX94S0woFkCnGS/tpV55hb64Uw9FL5U4E/olRgNJLHwimmvKH
	SDiIltEhrXr8llRcdBXRj7JTC65og8K1La5kiMUPNHA==
X-Gm-Gg: AfdE7clOXUpm4xwEYF7gdIoSIwoz20Tk0KXONx8Ds+WfYM7KryJZ8FkIRRP7v9sN4QM
	1ve3Zlq9fZD5ShdNL18L9DwRi/dKQDrdCs/kSJadnW8/qQZ4sgZpgqqBwL6S/7gp9Sv9TXGkOL4
	nzEUl8fF0QB8LzSYYg1hjRk+0NrhcWlIv5KS4Otiy6Q+uBc+ZtQX+gWENwfcGdDPJWNxPBR4epd
	NRBI8FIgnLU1OdJ0i25TJMBlHih9AOg9vnTO/HrFJlsHhz6FvRUXbzgx6oMHfN0h79Y0GollE3g
	YOUNYHWJaHtgbaVKqaU0BVjFq/JhlXzEMxpQ6UjM2V0xI4+NMpF4jwL10Y4=
X-Received: by 2002:a05:6512:641c:b0:5ae:ba7a:1789 with SMTP id
 2adb3069b0e04-5b011464f5emr1312055e87.13.1783582202634; Thu, 09 Jul 2026
 00:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-pwm-loongson-fix-v2-0-5492db953879@gmail.com>
 <20260626-pwm-loongson-fix-v2-2-5492db953879@gmail.com> <aktgrGb4CAO3_qFU@monoceros>
In-Reply-To: <aktgrGb4CAO3_qFU@monoceros>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Thu, 9 Jul 2026 15:29:25 +0800
X-Gm-Features: AUfX_myi0lnX6mUs2x1UrkfjB1AjluVusc0-Jo8udwaEHtcYX3zUvdMVHSTqCxo
Message-ID: <CAJhJPsUGcFz5YmTHBj8mN83bVuOdpJ0mtDHR_haVkgsrDQQGxw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pwm: loongson: Reload PWM configuration through
 counter reset
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:zhoubinbin@loongson.cn,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9652-lists,linux-pwm=lfdr.de];
	FORGED_SENDER(0.00)[keguangzhang@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[keguangzhang@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E86772DBC7

On Mon, Jul 6, 2026 at 4:03=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@kern=
el.org> wrote:
>
> On Fri, Jun 26, 2026 at 08:24:23PM +0800, Keguang Zhang via B4 Relay wrot=
e:
> > From: Keguang Zhang <keguang.zhang@gmail.com>
> >
> > The Loongson PWM controller latches the LOW and PERIOD registers only a=
t
> > the start of each PWM period. After disabling and re-enabling the PWM,
> > the controller resumes from the previous counter value and completes th=
e
> > current period before re-latching the updated LOW and PERIOD values.
> >
> > Reset the PWM counter when disabling the PWM and release it when
> > enabling the PWM so that the updated LOW and PERIOD values are latched
> > before the PWM starts running again.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
>
> This also needs a Fixes: line, referencing 2b62c89448dd ("pwm: Add
> Loongson PWM controller support"), too, right?

Will do. Thanks!

>
> Best regards
> Uwe



--=20
Best regards,

Keguang Zhang

