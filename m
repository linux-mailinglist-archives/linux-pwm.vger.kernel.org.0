Return-Path: <linux-pwm+bounces-5375-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1B8A7FBA3
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 12:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB04C17F473
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C06267707;
	Tue,  8 Apr 2025 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U54G7KM3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15047266EEB;
	Tue,  8 Apr 2025 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107357; cv=none; b=cn+zijFNFDm6tAErk9OWTMiFXcq0B75fRv1YUXu16nt4JUPvhaB5e0PaO5pWp0gcxKI1bxvXFor/5E3UHjhMYzMUcqOrVivYqyXVd25qi5f+PLSc+g/901Dgb14JfSoZRJy7zReJ0pr3k7yEAPVfTBURbhAb0sj4cQlGZKXtSvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107357; c=relaxed/simple;
	bh=F5jgsqXwGSznc/ks79mQwm/auTZ55zbs/7FmfTPKs4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Otrh0heJ4iCNKp7unYO0y+rNhALhveqEIO+MOQC40mJ6x4WNzi7v7WFouW3+uBxkPtjFN2Qjj9m31IcKGiDb07BlSG8b41AePg7Ct8qtvqlqpCU67P3I01qZZxR1NRyor9HeezRwSSl3EOslc08XgpxGPe58ukCpEnhx721Yhr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U54G7KM3; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c554d7dc2aso887143085a.3;
        Tue, 08 Apr 2025 03:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744107354; x=1744712154; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I9Ppw8vR47G47P1j9HJc/DVvecueKLo2E/NHI0ohsC8=;
        b=U54G7KM3MKzyVKjpeEKX3xfDzuKHc59R2lm5HVtqhBhemnYsnG88GfzqnjX97OP9Sv
         DoAnmxVxuKGZexlqz49LNreiFf9ZxXOZ8KsRkO/M82PBcAfZLHcXhweaMqpVwvMXTkn1
         b6WurudsMh64NxjekVovpEgju2SXcHsNhj05UbpQGmNKlQvyF8ibJueedy38I0Yd5NMC
         fwBYBuI/ljz4oRuQypDF4956FTiEVUoe4DB8c61Mk6O6Hv89o7Wt64EKXyvlDXSiM5BQ
         iBJXhR9jjTCuouKxQXPhRpB4i+UWP64DG/weG7BCCQzOKvXWn3mXkjUWz1bnSnfjxtVV
         RaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744107354; x=1744712154;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9Ppw8vR47G47P1j9HJc/DVvecueKLo2E/NHI0ohsC8=;
        b=Es33uBTtCZuiD3hUacxDw1m52lfHpN5P32biWn2k+RQsLb1qdoEIAEO7DYeiS/YQbW
         HiA7Aj5c+lcIp22Xdcaq4q0Iwue9sdtSHL53jEbQKMfkPYkfrXITNAXFJsbKOLf/A4p1
         UFMjHsnH4JowckiRAEB2rWxXruTRolQdCIF11TN9f6PAjuDEU6+yAHTr7R0LKE8rkbGo
         zVKaTKaam2j3FksyF3V2kG8Id5b22Hl2H/C8pnY7F2CW7s0K6vfrgVokVbvqE3vjSoA0
         /5oA2Rl4Jy6dhh8Uh0/V7SMWugv8UhSRMzp1UVnnN+QAzq4NIonkPCSrUc3807icBtIp
         kN+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVW1dSLqWNbUDLBx4esGxF0C8J+XlKHsuBl8oFzXh2DniKiLa+kDGcsOBR3mJpzSGN3rKSUOkwhnAXOnuzn@vger.kernel.org, AJvYcCVs7/5lcVv0CwY5N6t5lxd5UVxPCJQogxAJ81oBB2Hp3CgQ0IeNk3qJfS3069+7YDroAWJHnh8sR4bU@vger.kernel.org, AJvYcCVt3KcoGdQBzZYtajkFWQDzjO8oGBI4GsB6iNvIx/mzM/YUOHSicB7oy8DqiDfuDrTUgyoXf0CTWRfj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Av2G7/7nLfpY1E4ojXrOzpJmQIAARFD21+6w0kLHQYl5y8DJ
	zwWhwnN83rqbCeowYZc+LxmuZ5CUPm6dou5X8HglEXLY3XFveIy/
X-Gm-Gg: ASbGncutJDXZpla2J0CV6bNElBKhnaMKhvN7ck23io92aqMWbmDXwF+j+6jVHPYKETs
	bRFRfvgvEAfUsmYLA1cN48KILbrrIX8+rXkRiBNmGvOBufdLhmJYpS0zOTKYoUrsM7kLbk23V2+
	tHYX/07AGFtctE226oRpSUDVHZsOSRGcILfTEtQEwsM8G/bsfyLjI0OxoH6z/eMh1Fa4Px31RaB
	whuWpNIVVugseAEJOAiqoFK+70gzQXnINb0K8oYVxXbaBIrPDM5KdoSVAFo7VIUWyZeS01YN6Uy
	es0bzom03fRRGtv3WSUJZMm0tpIhLXo=
X-Google-Smtp-Source: AGHT+IH23+fBypf9fr3Elpk3n1gRkPJVqS8WHxAKtFVO5CG6iIAA5fMRsI1J8HrPQnuK8Bsg9SUsHw==
X-Received: by 2002:a05:620a:318f:b0:7c5:6a66:5c1e with SMTP id af79cd13be357-7c774dfcc5dmr2575493785a.58.1744107353738;
        Tue, 08 Apr 2025 03:15:53 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c76e96e611sm735194785a.62.2025.04.08.03.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 03:15:52 -0700 (PDT)
Date: Tue, 8 Apr 2025 18:15:16 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	unicorn_wang@outlook.com, dlan@gentoo.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
Message-ID: <laanxdjx2bd5zgxftefyjhfcih4mx54qzscnoavzosqvib463h@pclt37x4zomr>
References: <20240501083242.773305-1-qiujingbao.dlmu@gmail.com>
 <20240501083242.773305-3-qiujingbao.dlmu@gmail.com>
 <k6jbdbhkgwthxwutty6l4q75wds2nilb3chrv7n4ccycnzllw4@yubxfh5ciahr>
 <D8Z4GLQZGKKS.37TDZ7QBN4V4N@bootlin.com>
 <j74t2zqvoslo5fgmea4kp434tafgchkncytofj65zbbt7ivcqy@auboc3pkdiz3>
 <D913G6I023M1.NLMLJDZ1PYSA@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D913G6I023M1.NLMLJDZ1PYSA@bootlin.com>

On Tue, Apr 08, 2025 at 09:54:27AM +0200, Thomas Bonnefille wrote:
> On Mon Apr 7, 2025 at 9:21 AM CEST, Inochi Amaoto wrote:
> > On Sun, Apr 06, 2025 at 02:16:41AM +0200, Thomas Bonnefille wrote:
> >> Hello,
> >> 
> >> On Sat Jun 1, 2024 at 1:53 PM CEST, Uwe Kleine-König wrote:
> >> > On Wed, May 01, 2024 at 04:32:42PM +0800, Jingbao Qiu wrote:
> >> >> [...]
> >> >> +	if ((state & BIT(pwm->hwpwm)) && enable)
> >> >> +		regmap_update_bits(priv->map, PWM_CV1800_OE,
> >> >> +				   PWM_CV1800_OE_MASK(pwm->hwpwm),
> >> >> +				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> >> >
> >> > This looks strange. If BIT(hwpwm) is already set, set it again?!
> >> > Also if you used the caching implemented in regmap, you don't need to
> >> > make this conditional.
> >> >
> >> 
> >> I was testing the series and noticed indeed an issue in this driver at
> >> those lines. If PWM_CV1800_OE isn't set by something else than the
> >> kernel it will never be set and so, there will never be a PWM outputted.
> >> 
> >> Using :
> >>     if (!(state & BIT(pwm->hwpwm)) && enable)
> >> Solved the issue but as Uwe said you can probably rely on regmap caching
> >> to avoid this condition.
> >> 
> >> >
> >> > ...
> >> > 
> >> 
> >> Do you plan on sending a new iteration some day ? I may have some time
> >> to continue the upstreaming process if you need to.
> >> 
> >> Thank you for this series !
> >> Thomas
> >
> > I suggest checking existing spi-sg2044-nor driver, which may reduce your
> > work for upstreaming.
> >
> > Regards,
> > Inochi
> 
> Hello Inochi,
> 
> Thank you very much, however even after reading it I can't see the link
> between the SPI NOR controller driver of the SG2044 and the PWM driver
> for the CV18XX series ?
> 
> Regards,
> Thomas

I am sorry, I mistake this as the spi-nor one. You may want to check
the SG2044 pwm driver, which should be similiar. You could find it at 
https://lore.kernel.org/all/20250407072056.8629-1-looong.bin@gmail.com/

Regards,
Inochi



