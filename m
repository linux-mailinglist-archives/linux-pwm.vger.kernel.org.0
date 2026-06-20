Return-Path: <linux-pwm+bounces-9342-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EHSpK6thNmoy/AYAu9opvQ
	(envelope-from <linux-pwm+bounces-9342-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 20 Jun 2026 11:47:23 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A80BC6A8B4D
	for <lists+linux-pwm@lfdr.de>; Sat, 20 Jun 2026 11:47:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SWahMcCG;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9342-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9342-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE74D3004CB1
	for <lists+linux-pwm@lfdr.de>; Sat, 20 Jun 2026 09:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C66286D56;
	Sat, 20 Jun 2026 09:47:18 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97173769EC
	for <linux-pwm@vger.kernel.org>; Sat, 20 Jun 2026 09:47:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781948837; cv=pass; b=q3KtZcUPAO5jfjWnpc4+9sSfWksObXDdAkcYacR5LyahE6yFDW25g6ixCmOpkPE296XlyOId1mwMAsmBSxierRt8ZcDldz295rmmzbnIEh1uuBMyG7YIzSO8uSRONZ3n8WoJ2udJNd4BOUp02SjeAbQhs9mvva13zWKEPoWHMc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781948837; c=relaxed/simple;
	bh=xUcOXNLvQwqaM9qZ7NC4cNyDiAh2nAPZfoRZlNEk0Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQm74So3BcCfZVi8sklnlnQ5/joJ7sMPPiJgCK6qxw0AJtZ1y+bmkvxRfR/pctA10qQN34iRIze3ZzCNAjt2ccU9WU8ukwYTGPdSwJ/Xp1PXFI7Rxrzkr7AzQPyLihH1fRmc0jv+epCkZYl2dqMO1dzzrNBq6xs4aTbqDRdgfqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWahMcCG; arc=pass smtp.client-ip=209.85.208.177
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3997a6196c5so19304111fa.0
        for <linux-pwm@vger.kernel.org>; Sat, 20 Jun 2026 02:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781948834; cv=none;
        d=google.com; s=arc-20240605;
        b=R4YndvFc7g5Vhy/zy6vgUAK0KwhJ2Se+fArCd2nn7O8cLpiwB+FWcRgviqcFh+QB37
         L7r8if2hqdVbuFM/KvgoaJ7n0Bb+HSSCyKYewP1PEN5As8coLIZUKEkh6TekGliDkmU+
         /VN3JvnSQBtwKag7X456ZRLZj14ZyeYBKr0lgu7sUhYuocOSHHb2JUeQyLrzQ1GV5qWK
         iRG5LfJYxW5ex5ciGUDlXdqUmdG+o4Pc4a4oySTmipePEnDeXhA3VAEt5XbZmoC/mkmr
         sKCHiMGeQROwJwxOOOrX+D/TAjRSEqueHQttVds1jiCBFLgXpKrxvfJ1S9+uG0Q2DNo5
         IIOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xUcOXNLvQwqaM9qZ7NC4cNyDiAh2nAPZfoRZlNEk0Hw=;
        fh=5vji2cyZvvoqsmBTNIDbbwh099uFb0HrNpCWpMYmt4I=;
        b=R008PA+GYvBm0r3TeIk2jbWHB+PZ1G8qvoPIhyFFvEqX1QYTuNEIOzBCUx6avhCX2l
         kSCJDflDZQGAEP7xsTUvDGdeUHzKkXuD40dhQu9MLPxm38a9PGPvnFeTkKz8yMt9900t
         82jAIi6nE6++eatSH3HGJ3ft7a24iTQT17qXEnUIzZ3+hBQxoPUBg93a0eb3j23J4ex9
         VneKv8MYvObqzBOUMJ6AR/3LJ8xYhTO7+zIOAYQZgrNsXxeM5nFtJyuj/0dGkZAWk+wH
         ygfCDwfjl3zcXdBLZBJsBkX4ZBGOdWa/oA9R2lPVzW9TF6wF+Khuz3eMmFEmWk9Rs4eH
         jAkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781948834; x=1782553634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUcOXNLvQwqaM9qZ7NC4cNyDiAh2nAPZfoRZlNEk0Hw=;
        b=SWahMcCGh3hv5PkP88j08IQ5KT2fSU3Cd5/aMGlOrQWpuAJJLjaet/Fg6N1K10tsDv
         aaC/XVvD97/Hh2pWFS6xe08wLzex1qobMQiO/QzD5BXOWtGBq4/4ZvP7PhnQxoVtLPnF
         bP6AM/8whRJBzaBBKZOiivt2rLdA5c1UTiiRLsLE540WcuYKz6EgeaW+mYrwRAsU9ITV
         3jU4RWFoSISE45ciZ9UqrVpy58vpUWKDqUTqDP75xJdJyQk+w3bZT6qG2DsTeWbXEFHA
         vqlpODEoL9ZwinxphFZ+Zm1pAhyU/ZgschCR3zCGzFMR572DjQi6FoFEaV4ZG/twYGS/
         GelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781948834; x=1782553634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xUcOXNLvQwqaM9qZ7NC4cNyDiAh2nAPZfoRZlNEk0Hw=;
        b=m/Sf0vFBff2PT8jBEyPRzf/yISqHE1fn2fywaHT/50xvEZ5bfPwOiXrF0JnF8iGrgB
         I+kJDa+4xHuAyr+34PikPcsgS8x7MrgTrDPnOEvuaac8jywOintKqhN4/dhdJTGwaGzs
         5nOkws59ODhVCnPBIKolBtjRiw9i7M5IHMbQxznIlGa1aeH3KajO+kTb+sinfjt0QJfR
         ng9HnnsThe6d7GkTqNtoW7xUK1CKccWfkHvyJqC0L5ihkUljTfJxdTAl3rdBRidcSOv0
         UYOBVmqc+dASQG3QR9T/kaKwqVUUUcuGWyuev4WHMYjetfyIvgdDt9PAATGUhgrfCXeJ
         9MLA==
X-Forwarded-Encrypted: i=1; AFNElJ9/jSFn/YwvlJLQswBJXPzZ+iyN7kTVrvKtHK4caOJza9YiFJTG9+fG+qFcEn2sBrjbipEe6U5apjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH6Cqhyjc93KhQtXkbBswC6A44WF5OutBmyHjyj2ZiEIDgZ8h7
	kwE8c6sEYZaGa1aLVi74i8S3tvJOb/dBTGP6vN5tlyzTEG1pt/753ZhPsqMBcTnpt36Tyrvk7TO
	b69wCfTTg9SiVDxqhsCoyF5Pf18IGDdg=
X-Gm-Gg: AfdE7clgUaHrzNkBxDOfuEpaDlqkFLSqhdLtFQD7LeGQAGr0wh/9/PZBwhN3XxEOuJI
	jzHgrD7A048BLzPx0LGiE7eftFElKwG5ui0Z5MqOBWAIVyFVUxdc+4ORtnMG7tUpK3pQRSQebmG
	JFC2V3nNkZJ6aP0PB17jyv+gO2jHQXjs0RG28Kdlqk8jRNgvSyFHR1q56VfANmUddKjz5/pgx9L
	+GpMZcrJgwd+QE/dMZZ08C1lfNhTSw/IVX7nMe+GNaLX9J7QFTLMnP0AQ2mRfmbDnovKqfKfxlm
	kbath0ozyuhUHLmYpvBmDMg7qc3Cv//9bLQZ+TJIU7/eN7aF7j8Frv+cH/0=
X-Received: by 2002:a05:6512:250c:b0:5ad:5620:ba65 with SMTP id
 2adb3069b0e04-5ad562d1b58mr2172436e87.50.1781948833495; Sat, 20 Jun 2026
 02:47:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616-pwm-loongson-fix-v1-0-491dbf260a7f@gmail.com>
 <20260616-pwm-loongson-fix-v1-2-491dbf260a7f@gmail.com> <ajLFi7NpYQVcR_4I@monoceros>
In-Reply-To: <ajLFi7NpYQVcR_4I@monoceros>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Sat, 20 Jun 2026 17:46:36 +0800
X-Gm-Features: AVVi8Ce_nVrgpR-qRQiJ9KZSPtUUKcez0qgBWOCZ3M6gXIshc3pk5PIPf2h_BcQ
Message-ID: <CAJhJPsVoshaOWf3woe0LF1MJu8u_ivWW_14eSTsuEctehfVD8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] pwm: loongson: Reload PWM configuration through
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:zhoubinbin@loongson.cn,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9342-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A80BC6A8B4D

On Thu, Jun 18, 2026 at 12:11=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@ke=
rnel.org> wrote:
>
> Hello,
>
> On Tue, Jun 16, 2026 at 07:13:18PM +0800, Keguang Zhang via B4 Relay wrot=
e:
> > From: Keguang Zhang <keguang.zhang@gmail.com>
> >
> > By default, the Loongson PWM controller latches the LOW and PERIOD
> > registers only at the start of each PWM period, causing configuration
> > updates to be delayed until the next period.
> >
> > Reset the PWM counter when disabling the PWM and release it when enabli=
ng
> > the PWM to force the controller to re-latch the updated LOW and PERIOD
> > values, allowing configuration changes to take effect immediately.
>
> To get this right, so if the hardware runs with PERIOD =3D 17 and then is
> disabled with say the counter at 4, and later restarted with PERIOD =3D
> 12, the counter first goes up to 17 before the 12 becomes active, right?
>
Yes. This is exactly what happens when updating the configuration
without setting LOONGSON_PWM_CTRL_REG_RST.

Even with disabling and re-enabling the PWM, the counter still resumes
from the previous value and completes the current period. The only
difference is that the counter is paused while the PWM is disabled.

Therefore, setting LOONGSON_PWM_CTRL_REG_RST when disabling the PWM
forces the PWM controller to re-latch the updated LOW and PERIOD values,
allowing the updated configuration to take effect immediately when the
PWM is re-enabled.

> I think the commit log is a bit irritating, because (IIUC) you only
> change the behaviour when the PWM is disabled and then reenabled. If the
> configuration is changed while the PWM is running, the effect is still
> delayed until the current period ends (which is complete fine and even
> preferred).
>
That's exactly what I mean.
Sorry for the misleading commit log. I'll clarify it in the next version.

> Best regards
> Uwe



--=20
Best regards,

Keguang Zhang

