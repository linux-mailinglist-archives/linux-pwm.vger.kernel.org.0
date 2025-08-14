Return-Path: <linux-pwm+bounces-7060-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0216AB269BB
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 16:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DDA55E70B5
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 14:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388661A9FB3;
	Thu, 14 Aug 2025 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBq4fNYs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B304814A4F0;
	Thu, 14 Aug 2025 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181674; cv=none; b=uJTYJkdtud4QyIVqNkMixsUvIr3Cd2gKu8eT9IRouVFKZ/sJS3GKiXcNlVPr2iRcevHpI8gNqR8XBtXjb6QytvuqufH685/exsm//5kIq294SG/ssYpxKpkAWlOjSXf/tAkUPwadMeVWuK9B6iJmVEnvuqfGaL6IG+aFdNlVhmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181674; c=relaxed/simple;
	bh=Awy3n8Kfpi3JQmCappj3VUKmr0DBuJ40ABeIKPpW8hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOivPMmnTLd+JKst+hr8wOtZ8h3cWdcJlHGf1D6LMqjgPlnMHk+Abvx2xItfdX7Xqhry2cRMBxs5v/KcHJ5g9eGl8mnLtuDxEU+6SJhrcY1t3ptBbE04U+5KlaShVW+jPhfafGH7d/z9FyUVfZeSulQR1uQ+fwv9bN6S/oBDZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBq4fNYs; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-323267872f3so975919a91.1;
        Thu, 14 Aug 2025 07:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755181672; x=1755786472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Awy3n8Kfpi3JQmCappj3VUKmr0DBuJ40ABeIKPpW8hs=;
        b=gBq4fNYs+K/otbFX09xYD5Oe09V2t+9BedddglTs4lsMozwImQiF2AloRs1q09z2IY
         jOARvAgGcvxayEHqviI8m0+j9WuTQICx8wdl1n9iVb5259HwQk1AOyV9wEAqC4tJvHRZ
         a1LDifFOOm63bDwsmIx+rvRWZYX/70SCRRKRCxRqjTlN4vKbOkHZT0rPYy4/jAyNxAwK
         Xa6xfxTXSGQCRlz1AhVnigz1Uu+0T2Bi6wuOXxPPL4BdeSQGK3ow3T+uD8U+qtHacnrr
         ktt7LJnr2I9K8qsrpThpmuEBKP39COesRq4RPy6WiqMxbR5DCJ10/oT6ZEPaayCMFR6A
         Krlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755181672; x=1755786472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Awy3n8Kfpi3JQmCappj3VUKmr0DBuJ40ABeIKPpW8hs=;
        b=I+xWERImbHXBUjYkl9gokaWdUOJhdFM+CJKt0L+YlgvhkE3eCmNC4dvSSGfRHKptzz
         QgqioU/O8/bAIudtJq8zpthV7lJcmQoXctzdMVjB+RwPlWsxvJRvWxQbRKyVaDI6WOcv
         bPrd6wGlewukcP9Jr6mS0a63D2kMOiLRMlYLYXabWpgsCCKJeik4nvS8i3O9DKZQ7WXE
         fl7GzS630XW2yB9433H+f4TXtqL9Etq+CCq1kbQ76f1o/TO2olftnsJoKQue1oykNs7p
         SCuZetym8A8LCLyXbLSYa3t0RY+D2GBhh+TnUyMykLd0lqAikSmERYBMCSFpVgvFEcp4
         5GPA==
X-Forwarded-Encrypted: i=1; AJvYcCUb/+dozajgF3vaXncMgxOdfRyaAA0+O6WKhX+g7moK12LmbuJyQIDYAlXR03X6dDNp8wi2XjWuzpcDoBc=@vger.kernel.org, AJvYcCVmwQJFu56JlqeuGtZqiqYg6C3GFdspTlm5gDCN2E+DALbp2U6T/Q6V1wTVs7LIahue//AqhOZ6iIfm@vger.kernel.org, AJvYcCW9aMxwZWRALfwN4RRogzYdYCLiGHtAIgn0zYi0sc4OuHpIOm2MGTM7eDwB3qVKVIapyPlSDMmAQhrY@vger.kernel.org, AJvYcCWiExN0cPTzAhIe9NbnaThCfKe2pAHdjIM+/Ggu6++G/cWrMYgfFtZomDJQ1zv+6c4iQhbiN+Jv1El6/Z0=@vger.kernel.org, AJvYcCX9yOjm1Dx/6lFbu279H6XMdwb1IS4LMs8H6cdNWe/kbXpQuAC+Eug1AAwONl/IGuxNImdOjFPiRGJA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2GvsF7OsfH3zCFJWxXARmcYhEZwc9C4EXtOWZpI6oo7kHWa9b
	8Y5gyVrTAUFFdI5S6ttD7zRdQq1XCj+dGviEjULN0LEEM52A8WPLM1njvrXbmgtZtLwaXmHz4x9
	RQggmFTV5OuC15bfWBSYZjaLgXi5iRQ==
X-Gm-Gg: ASbGncsqHi+0hiIwiNh+OebkYvAjX8Ni8O4WnptY7SwfThSp5uLGTXg1Ieck5RV5d1q
	l0LRi5vuZxfffmWNPaucLYJrGsi+sNUd3PKaT0fcEsAt/PMS8Q/DQbuHUg8WOvuSBADoeVodLgM
	S6MpujN3nLpcSmJWVAJbJ2XQxjZ5Vj5LmajaFvy2OWn1ow6dBOvcb6dSzRm7nH6soLdojFQ1LfD
	xaeRS4=
X-Google-Smtp-Source: AGHT+IGfWM+gBEqMlS7c7zrD8ipF1auww1lSeaLBjQHLt84E8zAqKKYznSFzoDQMTqknUx8lOeQ+5JFv5XgbMJ+TGGA=
X-Received: by 2002:a17:90a:ec83:b0:311:df4b:4b7a with SMTP id
 98e67ed59e1d1-32327b6fb91mr5127905a91.29.1755181671822; Thu, 14 Aug 2025
 07:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814132129.138943-1-jihed.chaibi.dev@gmail.com>
 <20250814132129.138943-8-jihed.chaibi.dev@gmail.com> <8c9366a5-482e-4bf2-b8cc-79e789bf2ff0@sirena.org.uk>
In-Reply-To: <8c9366a5-482e-4bf2-b8cc-79e789bf2ff0@sirena.org.uk>
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Date: Thu, 14 Aug 2025 16:27:40 +0200
X-Gm-Features: Ac12FXyk9L6l4rag2sdISDeOTV4bIMeo93taJNhP2t-7KUD0dJkxa6u_-D_m2Ys
Message-ID: <CANBuOYpU5Q9C1rQ0PmJK3icz4Q5-b+BSZyKKQhhPFopeFqtJDQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] Documentation: omap-twl4030: convert to DT schema
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, andreas@kemnade.info, 
	peter.ujfalusi@gmail.com, dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, lgirdwood@gmail.com, tiwai@suse.com, conor+dt@kernel.org, 
	lee@kernel.org, ukleinek@kernel.org, gregkh@linuxfoundation.org, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-usb@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 3:33=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Thu, Aug 14, 2025 at 03:21:27PM +0200, Jihed Chaibi wrote:
> > Convert the legacy TXT binding for the OMAP TWL4030 sound card
> > to the modern YAML DT schema format. This adds formal validation
> > and improves documentation.
>
> > Changes in v2:
>
> This should go after the ---, tools use this to remove the changelog
> when committing.
>
> > - Fixed comment formatting (added spaces for better alignment).
> > - Updated commit subject to align with subsystem style.
>
> Should be ASoC: dt-bindings:

Hi Mark,

Thanks for the quick feedback. I've corrected the subject line and
changelog placements.

I will wait until early next week for any other potential reviews
before sending v3 to bundle any changes together.

Best regards,

