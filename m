Return-Path: <linux-pwm+bounces-3540-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FEF9952FF
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 17:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4C1287D50
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 15:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DB41DFE00;
	Tue,  8 Oct 2024 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTNT7ZgZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C5EDF71;
	Tue,  8 Oct 2024 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400218; cv=none; b=u8Emzr4/QMSAH/ntxLiqJVrVdGOV1IlJE84FxSF8cO4FSVh2gAC8Coj/Huj2nLBYaUb4IyMC2NKFgEWkCSsMfHBbke5s1/9kSxcoElQ1NTiO3sUB5zSZWG8iEwC5oE2umywgZjN/Pjc/t3WGbixZpRlY75zLzmSU7IRt+x1b6tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400218; c=relaxed/simple;
	bh=xo0C4U4wBPUyH7JhzEAeKIblQrARa9L8u8Zjshvxzx4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAFJ0dyGAfaB+fz4Yt/ptGZ8kBft7L/p5/rv/7GN157n9GpHtbl3TCKcaXVSlvoq9GtOhpsYoV5R+t/Vrs/fg13+lsCFskThpom3bE7kf7jnrGzMmhtoz+QLxbK9S6+iDSY6ip7WdPxf0mPS8W2zOwEzoB3qwnnDP0faPhFPpGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTNT7ZgZ; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-710e1a47b40so1728783a34.2;
        Tue, 08 Oct 2024 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728400216; x=1729005016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h8FVjFSOCkqIf/0pMIi/pzRKFL8gLTJryJEfNVlsG7Y=;
        b=aTNT7ZgZUGAkz2J5gxDkM/pnwxYkY0wcRZ7nR4YSpop9kR7fu0it4F4IUHn5vud2s3
         +K+EmW8DQ7e5RoocgeDB/VuHIqKQqhlmK3TNejfF4uDq8pur7xMZX8Fv279wxPehu4yP
         4qxjWDFLhOSZeWRqyIe9xT2vVE0DAQKHZI4yT35sHknHmEkCIgT5rvhbtEJEOe+OH83z
         O6EJ6nj3mHQHdsu2mkLnn6Ku4E3GxIJjRo6Pk6IvKepL6Bqj6kPpGkTJ02TxQtSYf9wN
         3rnfrz+kPaOFZ/lpXa2Y4Otk/gAfHWanTF8pxhB4Ov+sxcJsUpSyjDZXjHY8bxvef7xN
         erGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728400216; x=1729005016;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8FVjFSOCkqIf/0pMIi/pzRKFL8gLTJryJEfNVlsG7Y=;
        b=XZWmvxi2TxM1UxCHrb2Uo5q0gS4X8IpkS3P8Bw+f0Huhnybny/Ak9dL0Duy8kVciWM
         q8cUkP/aK94BYtkI3NgtvwlMiU+02617ZsCWiBs5scJzBEmn9xS2GLS0bAhXa6PyFGXx
         cZX9SqySyN0/bq6BjqGzSRTNLVVyXczZkw5WcM8HdT3xOLD6nMkiQeI+CnfK5ZZuy6Gl
         8didV4BpvkimM10pbbN21vJB6vPPl0iNe4rrKm/OqBEPkXYtH4MpIrpbpDk0K4uOOw/k
         ZJBEg7UbIZiz+dCsI+lyHDbmA/v2yicvnEzcFkCwLOLXEJaUJ9xCdGp9MLrII64wLhsf
         J1MA==
X-Forwarded-Encrypted: i=1; AJvYcCW42A+ZN5nYSxx8dic4wNxmYChqfk/Foba8Wp5YoN/CChyQou73hwnlARJr1CcWb4YPALuSqB38InR/@vger.kernel.org, AJvYcCXXETICo/ud72AM9Vgw5sEOPY+53TGPgx4GWKXycLI1q1u7OlqbLJgI87McCU0eLwUYIyx9WSM7Z2Hh@vger.kernel.org
X-Gm-Message-State: AOJu0YzuujGM9f5vpt1jqGKDk3Y5ZDR6zx7mi+HA9S3fcd12mUAqIggf
	3P4Eb4JIAwrB28MhRzITxU5j4ouBhsQb1QJwlKKnRXzHVDergkFH
X-Google-Smtp-Source: AGHT+IFYYXW7//lDk6FPokDWD1gM7PjS/UNrxS+imBsA3RrlBJLTTdO5nz6L4rCJS5C+eBsXjG/Ufw==
X-Received: by 2002:a05:6830:6384:b0:710:dae5:df1d with SMTP id 46e09a7af769-7154e98fca3mr10733642a34.31.1728400215490;
        Tue, 08 Oct 2024 08:10:15 -0700 (PDT)
Received: from neuromancer. ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7155686c95bsm1884579a34.73.2024.10.08.08.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:10:15 -0700 (PDT)
Message-ID: <67054b57.9d0a0220.359bfc.6183@mx.google.com>
X-Google-Original-Message-ID: <ZwVLVb5L08dVG0ds@neuromancer.>
Date: Tue, 8 Oct 2024 10:10:13 -0500
From: Chris Morgan <macroalpha82@gmail.com>
To: Aleksandr Shubin <privatesub2@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	John Watts <contact@jookia.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Cheo Fusi <fusibrandon13@gmail.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v9 0/3] Add support for Allwinner PWM on D1/T113s/R329
 SoCs
References: <20240520184227.120956-1-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520184227.120956-1-privatesub2@gmail.com>

On Mon, May 20, 2024 at 09:42:18PM +0300, Aleksandr Shubin wrote:
> 
> v2:
>  - fix dt-bindings
>  - fix a remark in the driver
> 
> v3:
>  - fix dt-bindings
>  - fix sunxi-d1s-t113.dtsi
> 
> v4:
>  - fix a remark in the driver
> 
> v5:
>  - dropped unused varibale in the driver
>  - fix dt-bindings
> 
> v6:
>  - add apb0 clock
> 
> v7:
>  - fix a remark in the driver
>  - add maintainer
> 
> v8:
>  - fix compile driver for 6.8-rc
> 
> v9:
>  - fix a remark in the driver
>  - fix dt-bindings
>  - rename apb0 -> apb
> 
> Aleksandr Shubin (3):
>   dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM
>     controller
>   pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
>   riscv: dts: allwinner: d1: Add pwm node
> 
>  .../bindings/pwm/allwinner,sun20i-pwm.yaml    |  84 ++++
>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  12 +
>  drivers/pwm/Kconfig                           |  10 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-sun20i.c                      | 387 ++++++++++++++++++
>  5 files changed, 494 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
>  create mode 100644 drivers/pwm/pwm-sun20i.c
> 
> -- 
> 2.25.1
> 

Has there been any futher updates on this? It looks like v9 was last
updated in May. I only ask because I think future patches adding
support for the H700 require this as a pre-requisite.

Thank you,
Chris

