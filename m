Return-Path: <linux-pwm+bounces-8286-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBL5MjgQuWkaoQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8286-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2026 09:26:32 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 396692A59E7
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2026 09:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C30353041399
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2026 08:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0C13988EE;
	Tue, 17 Mar 2026 08:23:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4E7393DE3
	for <linux-pwm@vger.kernel.org>; Tue, 17 Mar 2026 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735827; cv=none; b=dOrvUkClNowy9o1XpER9MN3POnpRxX+6NH2Z5vAh/Y42rV5WMgFUkEtkHEdhwbNuxAG7X/Yg0U6r2jcoaplPJE6MWU0Dh2d67xiADj88BeeV2yuOylhPlYKNJGw2Ddtbu+UrLPoovuLpV2EWM+0pnm87nqhxqmkrTVAYKm2Ysf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735827; c=relaxed/simple;
	bh=aTR0ByVDp5twPVDF0We0yxjjtWE6HL5DaVZrXfqb4cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnGBEHFbx7/cBw8OsBt/O3Su0w55YiZjZoIDXGyhjO9WhFuAfklRw3UYnuipd9YrcN+yrWUz9WxKyTuvWvujSD8x7pwwtKDjx2A4RN8ULK4BWvi0Jbzzj2XLbmBddJxJ/VlgKvesuZgFIBUaMfBd8lJftFG/N3fC6thMzMbcbMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56b6c3e0166so574263e0c.0
        for <linux-pwm@vger.kernel.org>; Tue, 17 Mar 2026 01:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773735825; x=1774340625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BWsLLpeb8S2Ruk3mIA0NNiewV90E5kBU5fFfxw9bA0=;
        b=qNttKkV3xKIGajVBZ2H4iHGxdhCqLJu7rI0T874193S9vOeXFBWHviewV8a65CY8Gb
         nvbApOJtk2CKVaCqauOx3MhLDUc9TGt16OmkbHp9vp8sqt0JTPLEhpnyFSsxhsnA+G0V
         7pE0oqPh1EdfYSNWEPZ2nh2kvQ3Tk/Str2r0xiZvExxiCxGKcDRxUJg+bzRbTfwtg2XT
         5BJQUGxGgl2li3+10XQuPq25torwYOqq3CSYDZ9cGErxVS09DvTMi2nnEQWAi2xGuTLz
         2lAsqiK6E+NV9NMg++PV8hyZ8Y/CZz+ov+pplCGQEGQtCCGmi9g3+x6Opwk2kYAUiqQW
         yEug==
X-Forwarded-Encrypted: i=1; AJvYcCU2clmUSPPOfBLu6UE1BAUg7u0yPEPcsAXGuolWKEB919qsVNNhc3wp1HHVKXINOevQoSXT5RCpG2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7aiIB93dOBoe0lFU6Mqh/3PacPz5gCRTAhu8O2lVp0ay2IEJ7
	0rny3CRyQU3zw0XKe55Zy7zil8/bY0kJYqtPGZP7XFjQLSPerQOJcs4WL1p2Wrn9
X-Gm-Gg: ATEYQzyP9GzoUii5T6nYUNKmWkIyHSib5y0CSp+IGegkk92vRyh5S54cG8+6ofWDme9
	IiGLRCwBvuVwj5AytSkVQcakFRpVmWOzZ2mdQ23gegNcKH24qO1KB1U7NOk2xk6vfUBqzT78cc6
	kXjpWxia+q4fCHOMeKlk0vnp2qlROXqv74e1VahTLol3lHvfD/m2tUnyJ0Mb4wi7adwHy9HP6Sc
	453Q2BhCUDM8Z2CQu4ptbcQe1PSWbrTRD1ULjuN1ugDXDKn6wytgtyUaBEU8kDtNMc9fraKf6Yb
	Hi9vWYM3iT67/ocxjMHySOGUXY416/j6ixpdw+yXGaYGJuNFN9BQL+HayX/2z1aPbHItDjcWF0r
	iNAkU2436XGoFl0ddt74FEmBWmR/qC7r7dzt2XeorDLVw8jIpKv/9Ec0vNwoaR8mtpEptgMKDZP
	nKCG+ZPFBU+M9qKIRElc/mOsYeWtwIcGbyRs/mqDnSjAig5XR4nbGTmXar/3idIdZJ9Yl5ta6t2
	Sk=
X-Received: by 2002:a05:6122:32c3:b0:56b:7ec7:bcc6 with SMTP id 71dfb90a1353d-56b95ef06dfmr1189655e0c.7.1773735825320;
        Tue, 17 Mar 2026 01:23:45 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b768d76e1sm4376502e0c.4.2026.03.17.01.23.44
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 01:23:44 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56b672c68dbso231321e0c.0
        for <linux-pwm@vger.kernel.org>; Tue, 17 Mar 2026 01:23:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1LbOmUgg+CwNRgvKK/5FMz2MYnv1W73oe8IyhLXkXswEpIuL4ZO8DM7HMrZVJCGetCqrZ1nA5tLc=@vger.kernel.org
X-Received: by 2002:a05:6102:38d4:b0:5ff:de83:3e46 with SMTP id
 ada2fe7eead31-60263d8f933mr1167606137.7.1773735823847; Tue, 17 Mar 2026
 01:23:43 -0700 (PDT)
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
 <CAMuHMdVqqGTmxiKRQBbphw8KmtG66HLaZhDVvtSK81cfiMsXcQ@mail.gmail.com> <TYRPR01MB156193245985A82B792817FE68540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
In-Reply-To: <TYRPR01MB156193245985A82B792817FE68540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Mar 2026 09:23:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV6c1F8eVOi6bQssq3qsBcpGnQ-cT1AeXLqXXYEgK4xrg@mail.gmail.com>
X-Gm-Features: AaiRm50jZRADgQIXJgbrFUg4WeDPSzcNuPJxTTXR-hiMiTGwpkXr0IAMZW3mmeM
Message-ID: <CAMuHMdV6c1F8eVOi6bQssq3qsBcpGnQ-cT1AeXLqXXYEgK4xrg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,bp.renesas.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8286-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.764];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-m68k.org:email]
X-Rspamd-Queue-Id: 396692A59E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Cosmin,

On Mon, 16 Mar 2026 at 20:13, Cosmin-Gabriel Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: Monday, March 16, 2026 8:26 PM
> >
> > Hi Cosmin,
> >
> > On Mon, 16 Mar 2026 at 16:52, Cosmin-Gabriel Tanislav
> > <cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> > > static int rz_mtu3_sibling_hwpwm(u32 hwpwm, u32 *sibling_hwpwm)
> >
> > Unused sibling_hwpwm?
> >
> > > {
> > >         if (!rz_mtu3_hwpwm_is_primary(hwpwm))
> > >                 return hwpwm - 1;
> > >
> > >         if (rz_mtu3_hwpwm_is_primary(hwpwm + 1))
> > >                 return -EINVAL;
> > >
> > >         return hwpwm + 1;
> > > }

> It's funny how even after triple-checking the message I was about to
> send, I didn't notice it.
>
> This should have been what I sent.
>
> static int rz_mtu3_sibling_hwpwm(u32 hwpwm, u32 *sibling_hwpwm)
> {
>         if (!rz_mtu3_hwpwm_is_primary(hwpwm)) {
>                 *sibling_hwpwm = hwpwm - 1;
>                 return 0;
>         }
>
>         if (rz_mtu3_hwpwm_is_primary(hwpwm + 1))
>                 return -EINVAL;
>
>         *sibling_hwpwm = hwpwm + 1;
>
>         return 0;
> }

Thanks, now I can see what you intended ;-)
As the output parameter value is unsigned, and never very large,
returning that value or a negative error code as the return value may
be simpler (i.e. use the original "bad" version, and drop the unused
output parameter)?



Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

