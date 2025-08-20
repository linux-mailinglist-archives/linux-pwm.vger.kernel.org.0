Return-Path: <linux-pwm+bounces-7110-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA16B2D4E7
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 09:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3B83BDE6F
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 07:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFFE2D6E7F;
	Wed, 20 Aug 2025 07:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFce0Dbv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC7E2609CC;
	Wed, 20 Aug 2025 07:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755675243; cv=none; b=uqTLrHKA/K2v96+QCojhwG5AN2kSUg5/Ub+Su/k1DzWCT482OVIwc5LoRYyl6lBN/2lvTTADp8g4zDhKKh7xa0WkC34Cb4bXTsxCWSGEIPsa5InnKUzgljUlbxSdTdzCEU0Y81o+foxowNx4jGgf1AgBuc7kYvjedcIr6N1NpdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755675243; c=relaxed/simple;
	bh=NPH4thYTD8d8rX7p3Z0pYtK52dCOuZkaVLpVKBjoEcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFiXNANEY59b31bDZr6CZiQFK90IxfVqb8WAC/FyqaLjDx2LXAC/a76Ja57wHXon3HnGOLkShwR6jyhpyiVvXt4CmAuCKH3d0arakeBaddS0zwFb/R9e1+c5+sSpUfGHiT+svc/Fl7mWlon9W03s7jj8DhLksfPYVkHHY9jA8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFce0Dbv; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb7a7bad8so835688566b.3;
        Wed, 20 Aug 2025 00:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755675238; x=1756280038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPH4thYTD8d8rX7p3Z0pYtK52dCOuZkaVLpVKBjoEcY=;
        b=DFce0Dbvcd8KMMZPrOBwK7A1RwsedMcCyqq/frIgN9hH/KY+mKAbpQl3rNSjUnkV1Y
         02Vv8BP4evwkR1pSUVPDs6Q4oGMvfq/O1a9fgGsmNJp/7PjyPXI4/0YRN9SOPEoQroL8
         gRAJTKTOp8NaeqsI6vsUSePwz3v54YQ0vkBEhuKbqfExtpq/V8uxYYQqED185hCZwFtP
         TqQe8ZfSqRfteHsFDLrzGd74TK5gHhZyPhtUprI492Su3tfUzLuWUhwyuKdR/NUl5gxp
         iso3bq8dEh5vNT66eYOW+dGzIjDcmwNZNr6jvddjcZJtF9kiM/Nani5ovU/VSInJCVbl
         oRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755675238; x=1756280038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPH4thYTD8d8rX7p3Z0pYtK52dCOuZkaVLpVKBjoEcY=;
        b=UonP2QzojExR6eRwUej79KkdqmZqj/kruDQYT6+OGA2gdMqv6L8b9Co+G4jCOKMIGB
         YvxzaTLUfz7ete+Ke2fZz85wr0g/+gNzz5TbF4djGjfG2ohdGxIRx8Ri5R1+IbkEQTch
         hPN4xJQrnXF3qVEY+PUuuEbIyXwEYFIl4/HCYnRQadoGcGVgM7o31w1n2MWf9oU5j8RI
         JJLD7teCRl3PSEqUs/9VBzL+A9ZiNf3cMlzWu/U0XHiOVWxmXYRAsaDikMbmpUmvJeuE
         tA8wNLp9upg3A423hHceSdZJCNKkwduUJrcxXhsYpW47Q0OkdF/BtZXWVsBJkbBAtpK6
         ddjg==
X-Forwarded-Encrypted: i=1; AJvYcCWEovPr2B4D7P6kjISAGVCVZEh8UwSXv5R/dsVS394Glhy9aNtA/H+BzJ0sn2G56gF2GMhn06y8tibW@vger.kernel.org, AJvYcCWdEnbP3uIyQUInXOiCv8Dx2j5T3bejp0rddyVbc/6s6/NcS/SDszrk2gxXyn/MSdye08adHPFWMS19mo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/WKW+3fhAiCIFi2ZIoS9J+g+ix8K3FCnlbZJWLufNm9ln/fyH
	34H/6i9453rZJXAwzyBC+i6E5z3QMSD6vh27RkNo5hH/RJgSdez2HpcPzfAS5gowGlNGa1o+wT+
	ZjnUMYJJiCUrqJh43lLroqMsKznNoHnk=
X-Gm-Gg: ASbGncvdJLxKM1FDIb3KpIrkY4vo7S23iQjsngM2vVGFYkVV9c/XV7s0QQ/42NQUDgP
	DDW35rZtHjtlmpjFXfnJG2JYuZpPHDN/cAbgfMpouX9xpr206hEwRX3alnsNgACIc1TjCHvPYOv
	NbNYJNFmTDTh1baiHeR5MWRJKGzoU/6e0FW9hhQkEEWIW7pc1z+Ux0UhLUvb+GqMk1NJo7+eLg/
	A8q2WA=
X-Google-Smtp-Source: AGHT+IFON2NnUMFGQ6y1o/aXI4xJqybFg6ldN2gTu+kqJGZLSRTp0BWFICixSl9b7AT59ymtz1PXsxoM5SGm987YyhU=
X-Received: by 2002:a17:907:3f91:b0:adb:45eb:7d0b with SMTP id
 a640c23a62f3a-afdf00f9432mr143256766b.15.1755675238083; Wed, 20 Aug 2025
 00:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816104904.4779-2-xry111@xry111.site> <n5kdswq7oduruqiruyup4rcdwrs76tlinz26swotzeqklterey@off5cbv5i4e5>
 <CAMpQs4LqEWSoMUZpcbyknuEvf48FMMgra+Jffk0AXvTiZYjANg@mail.gmail.com> <bssxtcjtp4pnt3cymcrqnuwdzgdhwk5udnqwsh3xvmo2kkd567@5ovlk34bb4or>
In-Reply-To: <bssxtcjtp4pnt3cymcrqnuwdzgdhwk5udnqwsh3xvmo2kkd567@5ovlk34bb4or>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Wed, 20 Aug 2025 15:33:45 +0800
X-Gm-Features: Ac12FXz8j4t0pSJL8egL9M4-K1Ue-Gu7CNjtrTekT8MsIOnDzp2kV69vcxiGTCU
Message-ID: <CAMpQs4+GHczLuu6dAE=Qo2sRXWZvQYktMPSgx6FFjnN5SO8BDg@mail.gmail.com>
Subject: Re: [PATCH] pwm: loongson: Fix LOONGSON_PWM_FREQ_DEFAULT
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Xi Ruoyao <xry111@xry111.site>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, linux-pwm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe:

On Wed, Aug 20, 2025 at 2:36=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@ker=
nel.org> wrote:
>
> Hi Binbin,
>
> On Mon, Aug 18, 2025 at 05:38:34PM +0800, Binbin Zhou wrote:
> > On Sun, Aug 17, 2025 at 6:59=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek=
@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > [adding Juxin Gao to Cc:]
> > >
> > > On Sat, Aug 16, 2025 at 06:49:05PM +0800, Xi Ruoyao wrote:
> > > > Per the 7A1000 and 7A2000 user manual, the clock frequency of their
> > > > PWM controllers is 50 MHz, not 50 kHz.
> > > >
> > > > Fixes: 2b62c89448dd ("pwm: Add Loongson PWM controller support")
> >
> > I have confirmed once again that this was indeed my mistake. Thank you =
again!
> >
> > Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>
>
> Thanks for your confirmation.
>
> My gut feeling is that this isn't very urgent and taking this as merge
> window material for 6.18-rc1 is fine. I still applied it to
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fi=
xes
> and will send it along if something more urgent pops up. Please tell me
> if you think I should bother Linus with it and get it into 6.17.

I don't think it's urgent either, so just take it as the merge window
material for 6.18-rc1.
>
> Best regards
> Uwe

--=20
Thanks.
Binbin

