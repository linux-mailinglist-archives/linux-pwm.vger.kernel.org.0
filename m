Return-Path: <linux-pwm+bounces-7924-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B20D3A98F
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 13:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57DC63002B9E
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 12:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B170736166F;
	Mon, 19 Jan 2026 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc9IqOtl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161CE326954
	for <linux-pwm@vger.kernel.org>; Mon, 19 Jan 2026 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768827292; cv=pass; b=KLeOrror24Ua+lUpjGYShhk5FfQdbaHneCAUcZkIgUaXhtcJ9TWMEJ0jXV8yOvul5FvIPmjILSIIXXSwJRPKiF58ywehFBC9sa7Z8xBeSh1EOWnlaX9wLzvge+i+GiB0AepO1tNe4cWmHsyHxE4+LlllvjNY59AkF9MuPrIO3Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768827292; c=relaxed/simple;
	bh=IkKYKGBczUCc6iecBFNUGNFccawVKBJFo/hayrkeNZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6c0Ywhu9rgJeiAYgA7mFmJbPXXuBscvsGSbAgcNsjOKGY1w+opF8C/809982gQ9FpKHuPj97KY6+OR+vah45NmV9nJ5fPXl6UNauI6RrNK8QSQb754kKga41wViiE4jiC+7QFRBgzvyuNBSFHqyROqDRVXHZTh7MIMOAN9pqeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mc9IqOtl; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-382fb6d38f7so29946721fa.3
        for <linux-pwm@vger.kernel.org>; Mon, 19 Jan 2026 04:54:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768827289; cv=none;
        d=google.com; s=arc-20240605;
        b=fUW/HkCnPl8uqZZnlV7551KaQG7bFJ65tO8RWqP17ravTc1s8jtsU74XHnGO9gd+hc
         0vU9WcMTaK1BbpGgeRVc0go2vzmT0L5uhjJWCAw8l1fUwcug8F7CXgsWrMRh8Reldl5D
         +PBXcQ89EX6cP6F3G/mXrvugjxBZ8rftPAqonVsOEFg0cvUujsUArq709KV0iZQsIkeS
         2jdOQEQ56yJR0CDXoab/RWdNCX0LF1E3pgGCnB6K5jIB63V9FSW8YDykJLaiZsfu9fNH
         +JT1M5cK72DkHSINHOmm/HHwVOiQxoAaD2TJgnY+18JoRgVHtrkUWLuwPEv7vsLDZHhK
         nkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qGur8UDGGcBE3Hmocy7dgLQOrypMFPCEL+jwBXmsi0Y=;
        fh=0enAhcHHuRjVzlnuTh+75RcMdT0zTl2HNdICIDBVBhM=;
        b=ICKxYLg/9bxvBmSUubpvNDz8ES6jJmB26iXyzV46h+t7v2S435lwAnxRAVrGQY+Eyz
         ComJga7NsnNPXQXj5ZUNxfl69GtpLnHjs3Vpf1/d6SQxA4HK7eBAOsgebZcu79mXzHzr
         ZQurh9QfDG2nIh4jHPxv3ijP3fcxpr6mdELzmsQy0zTQB9IQs3N9Rl14E3UXGzfBDmm5
         Yvtk0TpdNG5N5fT0JNbBrXCBRrIPCkJVO8LNzT8POAH68SobTYImsLgZkm+W5oNcwdcC
         0ezy1/MEIIPtuEYwJ2VabKlgjA9UIP92YjNNASV+yfZpNRsQMPB3SpoZxppQJvkjqRfS
         9h8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768827289; x=1769432089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGur8UDGGcBE3Hmocy7dgLQOrypMFPCEL+jwBXmsi0Y=;
        b=mc9IqOtlkn/IL3YKyUShxHqm9fvpV2shFOmy4YOozzrWEDkPUl/GHeT0vNGfBV7YS2
         4kmGZKeX2eU6zk57TMDvc0IfK3bewVF+yVFXD6fF9hjCblvzwaU1+r+d8IlHf4nib/9X
         XrFoV7gb4ydSmZyclg1ZO02jWzhVvQ5rYoFJSRpZaGu5oYW3GGr2Ie60v/wm2JRICIZ/
         arkhMFCtSxZOP+J3HGDdSDc6qn60/ZddUTS4dMcJAogAg3Lbrdm1eirDVVJmiz2ylnFI
         FeH3ACfFnHgxkJJQlgU97PU9eM/2wuPOK+vHRpDLA+He38XnfStKQa80D/N9d3rlWIPe
         qJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768827289; x=1769432089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qGur8UDGGcBE3Hmocy7dgLQOrypMFPCEL+jwBXmsi0Y=;
        b=pu33Nwox7bS6DXnP80kJejv157Bis98ZGWzf0/Es2qrnQmTbqyRllv5o6bvBQql8D9
         saWCCht12TBZRwL/pkp6umeEKWfcRNvcJmbfa73wACqpH8qSXbTHh0ef0gj3+VJu75f2
         HyeP8bDtyJ29LnojXc108Gm0u8V1hEkSarNXtHNITeUYEEJaSide3RZAOA8L79cpT4+t
         crKOfdGhp4Y8cVhd3/n70wiqZoRbIJev2ANL9eXak4nKuu26hIertI7BRHjo0QGUz88S
         fpHNtRRcJ70GSFofNtCB2EGuVo61OITPy9gU61EhKL9n282M16dA2+lj0t4ezHl1owpP
         jbvA==
X-Forwarded-Encrypted: i=1; AJvYcCUzTe9JT8iJRwVSqYR1u36F5YQrg1uDAyTNlyEF0AT6/6Zrn9ZOCyxd3i2lNgKAlFlwyXCiI/XJ/xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmhzbNuGjQbSRJF6emdHUoI33skNIimxtYElQFPUo1xMl3PCzc
	9B5jkHJWBpd0FGOnEZDOtaJNoh5p/AzsfmKUkPxTpOLZ1uK+yKpB/7/qxySKU7Axb6JIV92tmVk
	hqeZV9GHhYE9cRSFMrvci/c2Yx8sds2k=
X-Gm-Gg: AY/fxX5O7CL67YQV/keBke1XoAKsV8cgL1ITXKyAxqKP0P/WY36wtH4PL4WCOEr7E12
	J8tYIey4tyuQQhe9PTY5Wq/4ALjE39LOksUEUWorphYJGZj9Vyzv19AcHX3fCO3V6+zVfIuosKG
	hGW2DErtdEOWD4AifRInqIqaN67BWh5GR+knL/smWiOiNkSF/a8olXzO1mjm107YK4c/u2nMBmA
	bZp5pek+VZ0Avsoouf5rAAWDntfKuO33dbv5ye/NDXlIuy+eGd2t3fUvdkW4P1fziaLpqVIXhqO
	EgjUBIrx740dhLtLxAgzpc6tcVhXPuS4xVTip2k5+a8NR19RHfBhLO//ClmxRog5EH+CTn9c9vF
	KiE44bzdg3ZzsI7Y1kxxP4FMevrDrXlkAUD63pvUkRw==
X-Received: by 2002:a05:651c:508:b0:383:5482:b853 with SMTP id
 38308e7fff4ca-383842bcaeemr36918321fa.21.1768827288971; Mon, 19 Jan 2026
 04:54:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-cstr-pwm-v1-1-e8916d976f8d@gmail.com> <CAJ-ks9mrpcLaeiGjBcXNqTUwo00Y2MhhHWnWauou6exU1y920Q@mail.gmail.com>
In-Reply-To: <CAJ-ks9mrpcLaeiGjBcXNqTUwo00Y2MhhHWnWauou6exU1y920Q@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 19 Jan 2026 07:54:12 -0500
X-Gm-Features: AZwV_Qix7Aukya090jJW0kiXMssAD-LNF3xuSuIb8jpVn4bil5K-YxfJFOSV4PI
Message-ID: <CAJ-ks9=LNe_STYSEJj7tvFNFzLsfEBKd+=Nbft4Kj-7+RbU99w@mail.gmail.com>
Subject: Re: [PATCH] drivers: pwm: replace `kernel::c_str!` with C-Strings
To: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 9:30=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> On Mon, Dec 22, 2025 at 7:24=E2=80=AFAM Tamir Duberstein <tamird@kernel.o=
rg> wrote:
> >
> > From: Tamir Duberstein <tamird@gmail.com>
> >
> > C-String literals were added in Rust 1.77. Replace instances of
> > `kernel::c_str!` with C-String literals where possible.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  drivers/pwm/pwm_th1520.rs | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> > index e3b7e77356fc..8ae8f852ec02 100644
> > --- a/drivers/pwm/pwm_th1520.rs
> > +++ b/drivers/pwm/pwm_th1520.rs
> > @@ -22,7 +22,6 @@
> >
> >  use core::ops::Deref;
> >  use kernel::{
> > -    c_str,
> >      clk::Clk,
> >      device::{Bound, Core, Device},
> >      devres,
> > @@ -327,7 +326,7 @@ fn drop(self: Pin<&mut Self>) {
> >      OF_TABLE,
> >      MODULE_OF_TABLE,
> >      <Th1520PwmPlatformDriver as platform::Driver>::IdInfo,
> > -    [(of::DeviceId::new(c_str!("thead,th1520-pwm")), ())]
> > +    [(of::DeviceId::new(c"thead,th1520-pwm"), ())]
> >  );
> >
> >  impl platform::Driver for Th1520PwmPlatformDriver {
> >
> > ---
> > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > change-id: 20251222-cstr-pwm-c9b9a4701157
> >
> > Best regards,
> > --
> > Tamir Duberstein <tamird@gmail.com>
> >
>
> @Uwe could you please have a look?
>
> Cheers.
> Tamir

Drew, Guo, or Fu: could you please take this through your tree, or
would you be OK with it going through rust-next?

