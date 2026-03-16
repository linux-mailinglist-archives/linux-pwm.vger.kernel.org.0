Return-Path: <linux-pwm+bounces-8284-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFuDBmBLuGlTbgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8284-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 19:26:40 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BE129F021
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 19:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08E7A301701F
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 18:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830993DBD7F;
	Mon, 16 Mar 2026 18:26:33 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE43DBD5F
	for <linux-pwm@vger.kernel.org>; Mon, 16 Mar 2026 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773685592; cv=none; b=CBQXRh45Mrn29AmwrDuUpEj8krNuR9HnMnnZKRNrGcJsf4Vg4kkoQ+F7v//1hPJ95rQywsF/AKj76/KlVoi3dT3x7OnCrv5OSVqobujJUzONO8Rn/w82kPcNchJB8Xv6M9n40AGUXNgL2bgVIlBcWMRwOnFEEHZCrjN5W9cu4rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773685592; c=relaxed/simple;
	bh=eLT608Iu65e75yFDY2ephL+DnmrFksL+EdNUoRvOM1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3sjyuKMma6/38Y7rReOrWwMz1BIoIkzvjymsraMx3p6WKxOo3MDhZTra+0pSrNQ9jdyUrCjzEoY9CPUw4My1kqB63YsWhok3OazHqjV2v6NdyHLwWJDnj1Lv525LE7b/pklKqBdZ6PsU7/1VwdootKvLi16m98gCD8VtoVZZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56b71eef805so831434e0c.1
        for <linux-pwm@vger.kernel.org>; Mon, 16 Mar 2026 11:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773685585; x=1774290385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpQ1JDIESkHS70bwkrVznor7mYifAlL8o6+MvzPijrw=;
        b=EtP8dbWWsusFfXGTz3uFEhMuwxcTHSvnc7iDngAXlArwUq16f2VqndnROOwJIyYkqA
         Co/FJ74yxLHwSvrRaBLabmPGiJl5ecUqcrzdMl3t7fJSzCFSc3TjU9iCQsfdCWGVC2eZ
         lqIZyJjeHcyywOTkmNUtCiCLKdF0S4U/V7yWT9rHkizjM7wX/9Ov8hYFDcz9030shhrT
         /ym0oYPN813yob53vvvhXExw+EMh+R6gxfBKVVt9YM/CHo2Jxt+ots+8s2OlVag79Eyr
         3/MEFPS7tR3H7QQU7nG4/F1nUIVJgSGWUtdzPff2gyceYLR0hp/9lpo24/dxNxf7Zl+m
         Q4sw==
X-Forwarded-Encrypted: i=1; AJvYcCXBl4nihuJcv7edmpjn5htoSZkrEE5RFuTbcKn3LCZGCI07cALZTsCRwPTKwwJoT8BnMN6t0KVzLV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0vCBPo7vuPsZXpHMqPcmLnpMKQFc0l0kGYsltmIKVq9XdxYRs
	jBMcPGYixOGh5J9vluYGYOAJDJ0z1/CcDqzd8zyMrpvKUJ5I6BURsoc5hQ6bC4k4
X-Gm-Gg: ATEYQzwkVNpk0wkGfIJFM5qa6+BC2/Oho2s4uVhEe+0W03OAv/Xcgf3rqk4g1i1CsLl
	HaTqlmINcMFgcFI/l1K3eHdw3NdedAj9p7Pqvc+XFVtJNDn0WuXOuqF2caKNhmlYsJ/8+YiNQwg
	0D9zrlDc8DOWQLgbtTJ9VRsofpB/awMerBlatoMm8ipAAiyith6H393w9ap1+Mhff9jKqL8d9gj
	p1CqUHCmN2VMQqi3RgKbm6SjEJVEI+kCJwxMrYKfUOkjG9OH23/ci1qLhydQ7cDkLDKj2kgFvj4
	hNFxiDvDTegne0w4WEUBh+3PhMjRxRrVaiZGrM6xafogsv76oSJZRTyBrcun2FbyGFp18eGkkvw
	GUn3QT0jii9leLphkjUYGFb7XJk21d7M+wzBuzGBsW2zfqOe3Q64GRlZPRLWVDPrAIc0c03TrqG
	IjdrI5NF4Q6MCr02EeOW0uIqV2C5RnXopOytRp73g7B2SC47TgGRpnf+fnmHzMbYC+
X-Received: by 2002:a05:6122:d26:b0:56b:8103:79f6 with SMTP id 71dfb90a1353d-56b81038885mr2257120e0c.4.1773685585414;
        Mon, 16 Mar 2026 11:26:25 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b4634177esm8478702e0c.6.2026.03.16.11.26.24
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 11:26:24 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56b71eef805so831420e0c.1
        for <linux-pwm@vger.kernel.org>; Mon, 16 Mar 2026 11:26:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW33r7GEvaXAxcam5R8rktzpk8BSSW6RoSQRG2NVB/5fCLEg3cfuKhyUdd4LhsuB/C01lQAKkbz7C4=@vger.kernel.org
X-Received: by 2002:a05:6122:6286:b0:566:2711:d8ab with SMTP id
 71dfb90a1353d-56b628474b4mr4749468e0c.6.1773685583889; Mon, 16 Mar 2026
 11:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260130122353.2263273-2-cosmin-gabriel.tanislav.xa@renesas.com>
 <aaqTVDQa7xn70bR_@monoceros> <TYRPR01MB156191C8E77BDA44AE23A7D4F857AA@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <TYRPR01MB156192CC838EC0B3DD66246158540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
In-Reply-To: <TYRPR01MB156192CC838EC0B3DD66246158540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Mar 2026 19:26:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVqqGTmxiKRQBbphw8KmtG66HLaZhDVvtSK81cfiMsXcQ@mail.gmail.com>
X-Gm-Features: AaiRm52-cBzLFzQh3BVzaTMxkTLnHu9mSUGosGUtI9IHFak7XQqS486mq62zz2g
Message-ID: <CAMuHMdVqqGTmxiKRQBbphw8KmtG66HLaZhDVvtSK81cfiMsXcQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd channel
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, William Breathitt Gray <wbg@kernel.org>, Lee Jones <lee@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,bp.renesas.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8284-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.874];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,renesas.com:email,linux-m68k.org:email]
X-Rspamd-Queue-Id: 16BE129F021
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Cosmin,

On Mon, 16 Mar 2026 at 16:52, Cosmin-Gabriel Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> static int rz_mtu3_sibling_hwpwm(u32 hwpwm, u32 *sibling_hwpwm)

Unused sibling_hwpwm?

> {
>         if (!rz_mtu3_hwpwm_is_primary(hwpwm))
>                 return hwpwm - 1;
>
>         if (rz_mtu3_hwpwm_is_primary(hwpwm + 1))
>                 return -EINVAL;
>
>         return hwpwm + 1;
> }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

