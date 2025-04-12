Return-Path: <linux-pwm+bounces-5468-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7239DA86AAB
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Apr 2025 06:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941691B8815F
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Apr 2025 04:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303C62907;
	Sat, 12 Apr 2025 04:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="VXSWyCys"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0770342A99
	for <linux-pwm@vger.kernel.org>; Sat, 12 Apr 2025 04:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744430470; cv=none; b=dEWocdVFXxfK9teXAkfhga9XQAHTyCdKEFUrH3av2llvt6Ds1HtLPvPA9FPX16gY9ege43k25zB5kObqJ9OBzUtoAjYKszuWVzmLS6OUxYLmfj+Oskcn215He4/u8H0a6l/ITX3ThNu91ep6xbppAMSWrxXqF/VvZDGokIjz72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744430470; c=relaxed/simple;
	bh=/oaDy5SzWfzyFBs8bTU2LHsjy16/G0IhlbubH2Ym338=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/wx8jpIVv0YcZjW78JFzhPTCQ9Lx8+XblAT+dh/PI+RGuB/BLwegpMwP/n7Kf6CxU6+S3yXXMC0YVi7UHLnlu1gVYN4DMpYMeGd9voVTNMQbChXgi8G/wMi4BXSmhhBszFvllnm9NKDwSqyaoDDbYqFSfYeT2xLrkiRjkF3ylg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=VXSWyCys; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so3802889a12.2
        for <linux-pwm@vger.kernel.org>; Fri, 11 Apr 2025 21:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744430466; x=1745035266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CRPWfzlQeNRznSdwAcCFwL0YU/Q8vcd3a6wdTbE3VY=;
        b=VXSWyCys6KU+a6U5T4TSlQD19NnPRyi3Pm00IJ+KrfOFilFkzY2VwO5JK7kXaAG28G
         CmbfF4f22ZuhCkmMhOuUjyWjDsR8PGtdLdCGiQqMhj8Sxun+NEqTOmkVxqDEdidhFWqm
         1CSPxamDgZqwKwvFocUb6yxciBqvMlaUQEs/O8Bh8UB+mFAgr3kxWp3CRSSXeHD88wMf
         Og8DrtqyQvtUp2ITx9K92fbm9ooqYKB/eZCvWhPohCqdS3fbEe6wffQ4XNz84jsln1ik
         qGD6fRqnjP9ctZxh6DojlsSYx9Sxfrhj5awvMfXj204kHrL6h4TbEtTzG4xKOiBILJyx
         elqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744430466; x=1745035266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CRPWfzlQeNRznSdwAcCFwL0YU/Q8vcd3a6wdTbE3VY=;
        b=nSLSq5Fli9YBKTKHxwd4oyiWL5tvT3k9bW+f+C9tkfwXukk/B5EEdTWk/k2vKr7+Js
         JpRRHuxlWEFeycTwWEz0wAS7AMUw+tOikB4WjUUzLq4wBVbmkz6xlsI7Wgo1eVCq5BCE
         WVP8LU/cCFumfo5Pj3AJIIWpuReywjJ8ZiPmZ5G8254DbOcwOkziC0DCTZX2szuWLDe3
         7AihdF6i55Mkq1WtStdzUhBd/gWnTnVVujIeXSpnI8hcywNlGvM+TxILBU6KSCbzGjN6
         P7t/E/4wjGOFrfTA38PLtIJg2C8uvjimNFzbRlwz+IkIexakfdMGJOqwE4HqePQBpbkQ
         CNlw==
X-Forwarded-Encrypted: i=1; AJvYcCUonYm6X3cKSvxwMeOvpdVcRkrzzH2/oyegFawDoecw2Zbg7IP82v1ILYzAIC79psbQoBjlyc7p7to=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHS3ioYDIPk6m/BPjkEl93nST0h+YpRimId8/d9vGPmrmHPtHB
	wLy/jf5aoQNZT3mc+AZu9VpnnVAFBZhQJKCl9+awkXLnrWeVvqaapg0Ru11CXwFdCxuJOIM9boi
	QIEo8HPgDX8PRUxR0Ub0T5flEj0J9auCB1+EIow==
X-Gm-Gg: ASbGncvuQ+kyfPZqhlGQLVyJlMxdSgS2IJlH9suONO++WWIpK8yv/IcGtwVmwVCsJYv
	AYVXUm1JsDeysEJDPaG5qhIQ0qa3FVnHX36RsLUwJdDJn67lMNSN3i4GQMWP/SNIralkzCwWUPb
	uZA4BGfhbikqzJ42BAMiKgOGSBfg==
X-Google-Smtp-Source: AGHT+IENp9Rsn1tl1gtpbQVTMzSC6/93PX9bXuEoDkAlRHWwSvf7X/I+LUs0PiXsS9JvQ3CIAnw0CeEUzESATSMDzW8=
X-Received: by 2002:a17:907:c22:b0:ac1:e881:8997 with SMTP id
 a640c23a62f3a-acad3445eb0mr424260766b.3.1744430465564; Fri, 11 Apr 2025
 21:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411131423.3802611-1-guodong@riscstar.com>
 <20250411131423.3802611-4-guodong@riscstar.com> <20250411-spoiler-dispatch-8f709700a996@spud>
In-Reply-To: <20250411-spoiler-dispatch-8f709700a996@spud>
From: Guodong Xu <guodong@riscstar.com>
Date: Sat, 12 Apr 2025 12:00:53 +0800
X-Gm-Features: ATxdqUGgkB-PsMfv6YqmcddOd__4CXMlcvN5r0cbFMC6NhGoCTmz_wliYFT0jOQ
Message-ID: <CAH1PCMZcevte5kJ9PUO3cvoaFwdido=WboNcLV9dTk9SJuLGBQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] dt-bindings: pwm: marvell,pxa: add support to
 spacemit K1
To: Conor Dooley <conor@kernel.org>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, dlan@gentoo.org, p.zabel@pengutronix.de, 
	drew@pdp7.com, inochiama@gmail.com, geert+renesas@glider.be, heylenay@4d2.org, 
	tglx@linutronix.de, hal.feng@starfivetech.com, unicorn_wang@outlook.com, 
	duje.mihanovic@skole.hr, elder@riscstar.com, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 12:43=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Fri, Apr 11, 2025 at 09:14:17PM +0800, Guodong Xu wrote:
> > Add "spacemit,k1-pwm" as a compatible string to support the PWM
> > controller on the SpacemiT K1 platform.
> >
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml=
 b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> > index 9640d4b627c2..1e3cabf6a89a 100644
> > --- a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> > @@ -19,6 +19,7 @@ properties:
> >        - marvell,pxa270-pwm
> >        - marvell,pxa168-pwm
> >        - marvell,pxa910-pwm
> > +      - spacemit,k1-pwm
>
> The driver doesn't appear to handle this differently to existing
> compatibles, why is a fallback not used?
>

The only difference in the SpacemiT K1 PWM controller is the addition of
a resets line. This property is not used by any existing PXA-based platform=
s.

Since resets is defined as optional, I agree that continuing to use
the existing marvell,pxa... compatible string is reasonable.

I'll update the next version accordingly and include an explanation of this
decision in the commit message.

-Guodong

> >
> >    reg:
> >      # Length should be 0x10
> > --
> > 2.43.0
> >

