Return-Path: <linux-pwm+bounces-1653-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4759786AF55
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Feb 2024 13:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A7E1F26438
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Feb 2024 12:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA9B1468FE;
	Wed, 28 Feb 2024 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gadgetoid.com header.i=@gadgetoid.com header.b="iSUijGvh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD01145B3D
	for <linux-pwm@vger.kernel.org>; Wed, 28 Feb 2024 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709124252; cv=none; b=rdzi85q2WKtl3RyzNKaJxCnAq+RPDHasRDGes/mysiFptZd6+I7urr39EZZzALrTqqGQIR1lUA+jQ5tjQJDSrnRrPTEaHMeQmGCCrqko9mJR7Y2yTYdhOreb5uVpYcg7QYsvKhxub5HiKGSfjPDRJIt7Ky4JDBGx6AU1RgNO968=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709124252; c=relaxed/simple;
	bh=IGwU5zM0zY4cVvtezM1xrhTkBU9zL7HJUSFh8AoWk8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEH9v3g14nCaRGQZM/y2wgruxxwXsGE7BF8+6mMzg3CFYw7sKiLO3y4ON1PoCJO0XbR5nbAHbHAms9OMx1Y/mip19DXtD5GJWl4boA7mgygKH+FyMn1Zf7kI/7OSkEbscaEQHZSiazlK5UajRkPVWcCejDPFTFKi1f5wLc6xxZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gadgetoid.com; spf=pass smtp.mailfrom=gadgetoid.com; dkim=pass (2048-bit key) header.d=gadgetoid.com header.i=@gadgetoid.com header.b=iSUijGvh; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gadgetoid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gadgetoid.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so3674666b6e.3
        for <linux-pwm@vger.kernel.org>; Wed, 28 Feb 2024 04:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gadgetoid.com; s=google; t=1709124250; x=1709729050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oJ4g0FOhWvkWDmx+f4f+fdLyHXMFYJ10SOlrNRsoWXA=;
        b=iSUijGvhMiMuchF7kaA1ws72lLDgWQhe5h7ygUKC/h4+dvRPI9zA5dweMNhcr+Vpt7
         OjVrXpPOEGq86PZSBzkfCC6v6BohMOVNYWzzpeXOhItJpV9030gecALbWJmJVorsRxus
         O2xQzgj3rmOT3H/nAMIKYgNQNGIkksnf83DlTnDnrwacfOBThkPaGz75nvJRkdzrLJLO
         eaVPSs1iFCPINg3dxMEJYIspC5YrtY7mxslqYO4/cGhD9JocK8Y4MBXaFo/4zKShKs4Q
         N/tUDRCfls8xDhdA4oYqcGSzPTIxg7zeemxU3Sc+vk/VdjUWYxfAbG7WoNsUwGftq6C6
         H/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709124250; x=1709729050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJ4g0FOhWvkWDmx+f4f+fdLyHXMFYJ10SOlrNRsoWXA=;
        b=hV6IH+p6RnZ8Ug4LPRv9txDhWaScyYSFNpoVTiJheri0VSVBqtCnZY4ej8tO5t3O9F
         QVJp2yaakqIRQX1xz85qk2pXV+U+CvJHRyM49dYtUXtDH+Cj1cNWutFljM4EtB2gZH5V
         lnzck7//amWRNG16lxR6TcKj1S3FBUc4fHKEUC8j4sZnqUsPe8nmIGALPEfV3XAi/+4W
         xaVpg2myrskT2/p0ZZNksLG07NRGojLyf+dNa0FQlRsa/q7OiDY48AqoRjpE6Nuub5s4
         f+M3PJiTx5fC8yPlAuhgsK8X0Z9UpvmN+Cio55FC+DKoCI6JHHaCZo3pFLXSEnPwdNHh
         xQmA==
X-Forwarded-Encrypted: i=1; AJvYcCUCBoPhs7OPnjmZqQmCEsnGB5263fzw3OkYNJSx2h7A+Oli8srKzsb+1C+0tWxXtCrG9st7ceqDPs7E/BuyHWisBfJOOXbnLksQ
X-Gm-Message-State: AOJu0YzcuuSGIq4uyvoykiE4avm5DeFSFW2mtQfU8cAxhoT6+X4LHoI/
	1SbKM92Slg2g9BW8yxNgGmNoie3IToxNz2eYJcC2+elqz7oh96OAqb9JAHxmEZP2QAAWd4H5hmA
	oeJjPWIGWW4c5uPbJi+SaBdYIet9G2sgRuy1Jpg==
X-Google-Smtp-Source: AGHT+IFdqIozhMI0zw1aSNEMhrAwMA19VgeMD0K7kFekKR2uBaqpAJFV1qY8Jx+RVlVg5+/ehAkJ/+PWfN2rHtKQOaI=
X-Received: by 2002:a05:6870:d88b:b0:21e:9df9:2596 with SMTP id
 oe11-20020a056870d88b00b0021e9df92596mr13800774oac.42.1709124250028; Wed, 28
 Feb 2024 04:44:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204220851.4783-1-wahrenst@gmx.net> <20240204220851.4783-3-wahrenst@gmx.net>
 <65de00aa.540a0220.f1081.6933@mx.google.com> <3e65fd65-ccfc-4a77-8934-52791662bdce@gmx.net>
In-Reply-To: <3e65fd65-ccfc-4a77-8934-52791662bdce@gmx.net>
From: Phil Howard <phil@gadgetoid.com>
Date: Wed, 28 Feb 2024 12:43:59 +0000
Message-ID: <CA+kSVo9HmDvyCCezddJdZFUeJDGP9Lb5oKSMeXmzB78VvcM1NA@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] pwm: Add GPIO PWM driver
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Chris Morgan <macroalpha82@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	andy.shevchenko@gmail.com, Angelo Compagnucci <angelo.compagnucci@gmail.com>, 
	Sean Young <sean@mess.org>, Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Feb 2024 at 16:59, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> Hi Chris,
>
> Am 27.02.24 um 16:32 schrieb Chris Morgan:
> > I have a series of devices with GPIO controlled force feedback that
> > this driver helps us control better. So I'm looking forward to this,
> > thank you.
> Thanks for testing. I didn't had much time recently and i was fighting
> with hr timer resolution stuff. But will try to send the next version in
> March.
> > Note that when I set the resolution too low (I got confused and set
> > the period to 255) my device locked up hard and only a forced
> > power cycle could bring it back.
> Unfortunately this is a general design issue by driving the GPIO by a
> kernel driver and "expected" behavior. I didn't have a good solution for
> it yet.
>
> What period is too low without limiting other users?
>
> The only idea which comes to my mind is to introduce a kernel parameter
> for this driver to set a lower period limit. This can be provided by
> some administrator or system designer with enough experience. So a
> general user doesn't need to care about it.

This works for me. I also mucked up the period to see what appears to be
a signal in the MHz range, but got a dropped SSH connection for my troubles.

255ns would be ~3.9MHz which is quite spectacularly far outside of the
range I've come to expect from software PWM, but any conservative hard
limit would be trivialised by a faster CPU.

>
> Best regards
>
> > Tested-by: Chris Morgan <macromorgan@hotmail.com>
>

-- 
Philip Howard

