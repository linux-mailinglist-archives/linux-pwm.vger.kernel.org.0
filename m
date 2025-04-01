Return-Path: <linux-pwm+bounces-5312-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09A6A77252
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Apr 2025 03:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68749168BD5
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Apr 2025 01:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737B113C67C;
	Tue,  1 Apr 2025 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTWjTXvC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C7E6A33B;
	Tue,  1 Apr 2025 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743470913; cv=none; b=gitlhcj2JHzpLGr9uDyKnGQ7NLfZzYT20EKiyImvpbfCCX8LOuzxOAgYmKzAx/ug160gFk8T9IvlgIK5/ljPk6wBsriFPPDk64sPX8OLfDQ9SDh9o2pzIHoMdJL5hFSwBsf/ysw0hIFYDpDNa/RjAg8VGjelS//8YwfN3ydN2bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743470913; c=relaxed/simple;
	bh=m19wp1+qd0zKInAT915y9W17LSkxdTNL2RvcBHT5uXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P361NkhE5Se9OHrkH3Gy7uML+PidcdlsrmOLL0mSyX6UPxlq6Zioxqcre/JrRXPBnlGA9i0hWo0n33Bctn/XYA6F9hXABe27o9KiIDJ3lM7Hv8kU4i4dV/vDNFGo4oFj3/sAY0UMDFBtdO7grtVNBI38tSVW3ZITYNPX9Hi6m4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTWjTXvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FDFC4CEEE;
	Tue,  1 Apr 2025 01:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743470912;
	bh=m19wp1+qd0zKInAT915y9W17LSkxdTNL2RvcBHT5uXs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PTWjTXvCcUnasUodvlrnnF0dr9ZUhgq/ydy063wqquo2xeUJjKZtmFZ1tmNSaYVwi
	 2+h1LZb+8CUuLN29w4E8jYOvegaf1Imn10A7TdrbCAShIZrGS5p5h4oGKaO6gvBW96
	 EzntVQN9DTJ2qQ1q28xS9fzQuc6pbxqnE+R/EtzAl0wglkkhoDxIC2WpZ825YEdORs
	 V0H1RYxwTjUMYs8NJs8fmXkApEUxsq9S8C0TGTRb2+CE4HnDUwGM6LajJFI8mYZLIG
	 ScK8YDn00u+aGuTMhecac4+bfoAM+2XAQ3mZIzbNJc/W7aNRc8vEEsYQziLpIOeIBl
	 En8eMMJiM0f2g==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso1009403866b.3;
        Mon, 31 Mar 2025 18:28:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvvaPk1wCTXqhZpaWgOOZE7feBL42e9kydKzyNudetXR71Q9er7oJzh2RF/aqWDZu6wYAhcaKWqLt1@vger.kernel.org, AJvYcCVJDL+T89nKdnRbwB6VvqTeJWsLRP3nXWhGXeT3D6gjvIiTce+rvtu5R3T/Kv7N5IiL/DInNNDFhLNW@vger.kernel.org
X-Gm-Message-State: AOJu0YxK2qw32WFUTL/4SbXrpi2gsDxrRF14sOcTm8jBoWfGnxHCLEcY
	+hZ9andBC9vu7o/vZQBRYr7gP72S8xVdO6edWuui4irD/fLueZ655japsATSBZT26Hl7eAB4J8e
	FSCDq9xdaJ8YPDWjtsHBd210awQc=
X-Google-Smtp-Source: AGHT+IGgG1Nsg6TIae/1JBbjS1Lsi1zVJj+BXszVrJTrloL3d5guVx8xHxArlenv2sIyuyn5yKV8+U7MzPjhAqqfDBY=
X-Received: by 2002:a17:906:f5a8:b0:ac7:3911:35e7 with SMTP id
 a640c23a62f3a-ac782ead5ddmr84107066b.59.1743470911115; Mon, 31 Mar 2025
 18:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743403075.git.zhoubinbin@loongson.cn> <zfdhcdy27q5dhaezc22bmx3dnmn2avazsfbpsd4k5lyjikmxnd@dsdbbokjjjag>
In-Reply-To: <zfdhcdy27q5dhaezc22bmx3dnmn2avazsfbpsd4k5lyjikmxnd@dsdbbokjjjag>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 1 Apr 2025 09:28:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5Ter6jYObtffAU_ixUy97UQyU13YRwKcE__hZAPZG5vQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrmtBIR-Ec8RwbiRAx-SJRnlMqzQKm7UogoAX_fed_d-wGUvckU0wpF-WM
Message-ID: <CAAhV-H5Ter6jYObtffAU_ixUy97UQyU13YRwKcE__hZAPZG5vQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/2] pwm: Introduce pwm driver for the Loongson family chips
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Uwe,

On Mon, Mar 31, 2025 at 10:52=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@ke=
rnel.org> wrote:
>
> Hello Binbin,
>
> On Mon, Mar 31, 2025 at 02:53:48PM +0800, Binbin Zhou wrote:
> > This patchset introduce a generic PWM framework driver for Loongson fam=
ily.
> > Each PWM has one pulse width output signal and one pulse input signal t=
o be measured.
> >
> > It can be found on Loongson-2K series cpus and Loongson LS7A bridge chi=
ps.
> >
> > Thanks.
>
> applied as v5.16-rc1 material to
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.gi=
t pwm/for-nexxt
For v5.16-rc1? Maybe v6.15-rc1 or v6.16-rc1?

Huacai

>
> Thanks for your patience and effort to wait and act on my reviews,
> Uwe

