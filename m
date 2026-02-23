Return-Path: <linux-pwm+bounces-8154-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2iUTEDW1nGkNKAQAu9opvQ
	(envelope-from <linux-pwm+bounces-8154-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 21:14:45 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E9D17CC62
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 21:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30DBB30420B7
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 20:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E96376BCA;
	Mon, 23 Feb 2026 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EZjkfbf5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9D8322A1F
	for <linux-pwm@vger.kernel.org>; Mon, 23 Feb 2026 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771877681; cv=pass; b=PQdAQA4+7hwtiP9u8v1c95E1DwLtskLGSTrleuBxpmH5LSppEJttnIX7rRT5hyXYzbSjgd4vzAZHc3/hhcsb0S88UWqAcQfUSrMmBdsz7+V6sczPbMw7wiEA8FWF2m6hMzDa1WuLtQkF20CeWu3heOlBIaf4YPkrbDSCyF3TU/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771877681; c=relaxed/simple;
	bh=nA16AXtOAnzAMKQXT0kCHh4QEsWPir743Z8UnTfui7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkQifRdn1mw065fNBctq+ZqmuYfwdaeupF5AMvwo56/O+Cu3y0n5Gs7FmxqdzK86G5ECcDXS7MFgWM2U/rML4ki7io7zvs37i/UBTzvtr9Oa3sBHbvi+Vx0+3+sFx1UdNIpQmbiqxoMFBEmpdGpkAy/nqL5Pf8/Da9g175Y2Tps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EZjkfbf5; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8fbe5719ceso789471766b.1
        for <linux-pwm@vger.kernel.org>; Mon, 23 Feb 2026 12:14:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771877678; cv=none;
        d=google.com; s=arc-20240605;
        b=SbbDZk7CmB/P+J9y607viyyIP+6t67PLybf9EpoveVIFuGtCDwKaktjLnEUhpEWZJ4
         90gSLuaZxCgPqaOvCXQ8gW78/HLk3iCeyFAVLoEFBRw/nw3cFBoV/qRuPuFNebLltoGG
         8KXIchccoADdyrzGpQf3SAueF2dXyYD5SE/0lC6/wkxzIC7uqHraC9lFIJj6PVqNP+kZ
         DSczl0HFhS//Z8phB5ZKWaJDh0T1EKz9mmGTYLpy9GU0VgMBeg8F+DH+lIdoMvSsaEhH
         ikuNt4Dwk8Jgp4Y0o091kAfG/xVSBY/nxxnQN2MnKUKZ8wG0DJ2lTzXAsQZn1ZJdeRjJ
         NOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s5RZgQiN9LRRPBUwx9tg90lOISfa/rsQmb3YEFiGi18=;
        fh=Yyr8q11B5Aa1WSmWuiO9DMLqvmPfn6PkbJsUNGhslU8=;
        b=CnvkWV27MdyfltFolaNsEC7cpNySObGz3AkO5SNfVaS71HUHDpakHMjaeV149RB4wd
         C9eDQt5ZKL6LUFrzXRCfshpgYMs93I4MH8IfjCvq0bwtY5wMeX8oDqUsf2+VSvMpgIMw
         /xOfT99qLJ/IMq4wW9imbb+Io88GU9k0Hw0DHlZhs7YiBol+eMknhM56qBnwQF86ATzL
         FDY9irfzBON8zHKvvqR9HnCCSOAarnjKrA/9+tQmyMrR3iuDS6yiF6yVa0iw0bbC6FhO
         f/lRxpJ7cZfm2qfumdst/S7IOKEXbYbyP7jkN8UpzjSmUwfUFvozLdWeSEU7lOLlYWLD
         iYJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771877678; x=1772482478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5RZgQiN9LRRPBUwx9tg90lOISfa/rsQmb3YEFiGi18=;
        b=EZjkfbf5ie7gGdN8vlEJxwWW5bGdGtsH2NXZayCUJfyOSqdfEGREHFl2CbTkFuCU+7
         Fxtk1VJWxZc0FVKPZtvLtsAeuDL8eFzrxcvxH7vE1DGcT+pbJwtYs1raaXcK5mgvNaMW
         Y+j7/98iAnL9xEo3ENsPb4uYzfGbMCEFf3v3/FxEJmhnX9gfNc6HE4Loi/6MbsmBSk6H
         M9YU+Xcr+2G3xt2yPL6V3f4IEIX7JQGPoT9AbHAh2i6F4IkdCatvLhq2IjBDvMyAV8Hf
         RnlkiMuKeJibnDh4/bDpu8I4NxmThfSzKfPYhnIWKc0ZrK3YaaecwNxEuCtslNFbEdif
         nl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771877678; x=1772482478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s5RZgQiN9LRRPBUwx9tg90lOISfa/rsQmb3YEFiGi18=;
        b=awCce1Lmn40F4dQOVyX75iE6ydWASjS2MYhWV3MMOAnnVkgf4O1bGiH0fl6I6gptc/
         1NC2AKDPX0T1E9jSjm9F4cp1lZb4aQhQaOa/oc2IXAOc6BPEEDHW8nT1QJbGaXLOW0Tz
         MUjOBwrbZTFd+0uckATo+rAN1lhTOW+xA9p7IgU67ID7LEyLG3nt+vaR+E2Q0m5wqTG/
         QqcxR4DmAux1gf53EvvOF5C+GUzuZL7Ww2xbyJeCFKTikV4ApAW4tqWkFvWl5EAuqkor
         O0vGc7sFqJ/l23u8oRZS9EqiN9H/YmvU+BqVfMbmhLop6TqiSVMSxzzB9kiCMqGa7Ryq
         7oWw==
X-Forwarded-Encrypted: i=1; AJvYcCWTg+Cfo0cNqh59XZgfFrNABa/M9sY/fVOiA4/xsBz5llUXzAoAg8EujzzjNc/ZQrN4BYW52FashJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym4ol0S9ypjt3yTK4EyioQypbIFMuj2Zaj6IXOAPT7s6wzQR6c
	9XsF+lVBB/jLB2WRF4Dh0iYi5j0tGL/TcF6TmLJOAhKIRaJfABeu04MpJT0I6HAAznpW4S7335d
	7VtSiE9CRMA4PwTiahqCEW7kZ+IHugSj1lrzIrtw=
X-Gm-Gg: AZuq6aII4tYCz9Xv2soAbg0N+SwRH/EZT71tNNNC8MWK0oAyIBqwcRo3+6CNXXe7sse
	HW+EY5eOiZd4czjlzpyG8BF0DWHE0o1vz4LfdEW0WwWRQ6S6Df1hOanaKCtP8U5QcQqZnzJo6Pl
	PsIGws7pvVmpPzI2LhY7BHTMNu6dhKQ3wSq2UAeiWZxpXx7nHTLamZj0DxyivNjj4Od19P0TmUY
	NgcLMvB5mDcqG98FoSlfqz4gTRDHTaTkfYnPeg/KrCqFSNlrqwYoZdDoQ8Pi75rOJr1+cXIqKpz
	wop5JDFpNf5vcdbDLa/uqh24qYJvdarKV+3M
X-Received: by 2002:a17:906:eec4:b0:b91:949a:721 with SMTP id
 a640c23a62f3a-b91949a077emr32138766b.50.1771877678105; Mon, 23 Feb 2026
 12:14:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123093322.1327389-1-richard.genoud@bootlin.com>
In-Reply-To: <20260123093322.1327389-1-richard.genoud@bootlin.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 23 Feb 2026 12:14:26 -0800
X-Gm-Features: AaiRm50Ga4oMdcVdPVuyNBi2IGP1JlBI-F2cv9ZWk5n7MHWt5lEEKQ1itdDrDwA
Message-ID: <CANDhNCrSjp1F0PifJXmxrAbRiTC=d_ZXeiiT5kGuM=gNke7ebA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introduce Allwinner H616 PWM controller
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Paul Kocialkowski <paulk@sys-base.io>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8154-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,csie.org,gmail.com,sholland.org,pengutronix.de,sys-base.io,bootlin.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jstultz@google.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Queue-Id: 93E9D17CC62
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 1:33=E2=80=AFAM Richard Genoud
<richard.genoud@bootlin.com> wrote:
>
> Allwinner H616 PWM controller is quite different from the A10 one.
>
> It can drive 6 PWM channels, and like for the A10, each channel has a
> bypass that permits to output a clock, bypassing the PWM logic, when
> enabled.
>
> But, the channels are paired 2 by 2, sharing a first set of
> MUX/prescaler/gate.
> Then, for each channel, there's another prescaler (that will be bypassed
> if the bypass is enabled for this channel).
>
> It looks like that:
>             _____      ______      ________
> OSC24M --->|     |    |      |    |        |
> APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> PWM_clock_src_xy
>            |_____|    |______|    |________|
>                           ________
>                          |        |
>                       +->| /div_k |---> PWM_clock_x
>                       |  |________|
>                       |    ______
>                       |   |      |
>                       +-->| Gate |----> PWM_bypass_clock_x
>                       |   |______|
> PWM_clock_src_xy -----+   ________
>                       |  |        |
>                       +->| /div_k |---> PWM_clock_y
>                       |  |________|
>                       |    ______
>                       |   |      |
>                       +-->| Gate |----> PWM_bypass_clock_y
>                           |______|
>
> Where xy can be 0/1, 2/3, 4/5
>
> PWM_clock_x/y serve for the PWM purpose.
> PWM_bypass_clock_x/y serve for the clock-provider purpose.
> The common clock framework has been used to manage those clocks.
>
> This PWM driver serves as a clock-provider for PWM_bypass_clocks.
> This is needed for example by the embedded AC300 PHY which clock comes
> from PMW5 pin (PB12).
>
> Usually, to get a clock from a PWM driver, we use the pwm-clock driver
> so that the PWM driver doesn't need to be a clk-provider itself.
> While this works in most cases, here it just doesn't.
> That's because the pwm-clock request a period from the PWM driver,
> without any clue that it actually wants a clock at a specific frequency,
> and not a PWM signal with duty cycle capability.
> So, the PWM driver doesn't know if it can use the bypass or not, it
> doesn't even have the real accurate frequency information (23809524 Hz
> instead of 24MHz) because PWM drivers only deal with periods.
>
> With pwm-clock, we loose a precious information along the way (that we
> actually want a clock and not a PWM signal).
> That's ok with simple PWM drivers that don't have multiple input clocks,
> but in this case, without this information, we can't know for sure which
> clock to use.
> And here, for instance, if we ask for a 24MHz clock, pwm-clock will
> requests 42ns (assigned-clocks doesn't help for that matter). The logic
> is to select the highest clock (100MHz) with no prescaler and a duty
> cycle value of 2/4 =3D> we have 25MHz instead of 24MHz.
> And that's a perfectly fine choice for a PMW, because we still can
> change the duty cycle in the range [0-4]/4.
> But obviously for a clock, we don't care about the duty cycle, but more
> about the clock accuracy.
>
> And actually, this PWM is really a PWM AND a real clock when the bypass
> is set.

During my free/personal time this weekend I was tinkering with Orange
Pi Zero 2w and was able to use this patch series (along with an
hdmi-phy patch and some dts changes) to get HDMI working on the
device.
I'm eager to see these land!

Tested-by: John Stultz <jstultz@google.com>

thanks
-john

