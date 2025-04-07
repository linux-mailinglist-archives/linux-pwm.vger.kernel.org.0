Return-Path: <linux-pwm+bounces-5351-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFCCA7D600
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 09:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C1B422EA7
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 07:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D434E22F16F;
	Mon,  7 Apr 2025 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvd3HFe3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2E922F147;
	Mon,  7 Apr 2025 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744010557; cv=none; b=kAxzDiKpRgPPFlu4lnpZd4x8QKEMOOC/wW5+Exe15Ma4KwfdDw07V/HGpHKnW8iahsoRpq+LJBCpkY1VwQUTZuU8/jZXFr5faGDDLbLzz97InJ6DSjae0i8QslVMH6Xk5P5bsFFQABqslv9S/YY0HsXGmXpUkthB6ueymuVclIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744010557; c=relaxed/simple;
	bh=nmOKjuS7TC7DKph8mPFzB3pFke/l4HyzYacAFo9jAKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XENJ7uoJAdhO+DeeCpH5UyolhelJ60tfsTQ6lwbVF+tl6PsH8pwr5lkXEqxEhNtAcDieAQfb7E9QmNbpBZQf3kIETJH8pf8ZtJjrjW4c980vJUYcQh/U8/NTF6VGjS6TnOkzmN6+GhYjBsk5BCxwciSGFFcPPOmb1b4U1H0JGtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvd3HFe3; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8fb83e137so37271476d6.0;
        Mon, 07 Apr 2025 00:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744010555; x=1744615355; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MX03ysAjKaZdIowjU4awTheS3TG+TO5PNjERpNEqYfY=;
        b=mvd3HFe34GF/PgGdY6Ja78ggtpuTnKb+g+6BlU2RJbCC6A38iqJsQDB07es7WrPc4j
         DwkjZkMa7WdHTn9YcI1ia74wPxuGcgbLIXG2XZAgDSwJ/4wgyxiBQ+I4hel9KkAD6aem
         3jImlFSgSIoP7WUI8rz7BdqxBNM5UeO0XhEtDUVu5rGbzePVl0KYBOKpctzvf/JAwGEx
         t1U8b66vOsOmxKOlVkYf2FH9bWmDlFBTrysd5nALdZIBDzfzDDtgGeweoc0xlyqNSJF1
         f0RQO9FjOPPqALJnQOMKggOmooMbyDQDxD9pXFoZnA9986/EHegC9FT0mWGKPF/PbKUf
         7I/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744010555; x=1744615355;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MX03ysAjKaZdIowjU4awTheS3TG+TO5PNjERpNEqYfY=;
        b=HCnln4CGsTMvmOvquKEQKZ+FPShFurJNWjM2g0pRU2OQCyHOSRoPUq0kJZuoCIukLc
         +yWw4SqLagMo5XIb+fuG2qRgdT9urKfspkJD6y3/8Oz7YcR46zBpHPZRN37geIHDFald
         OcOIbHMY0pfuV+KoOSm/Nz43giGJ5AvPKzXKUZieUVGb80Y6v6YtIti8hS3PfGkfZGkm
         zjnlkwUysXpgkgLHeHfK9THwUdVtzl+8AdZwUTG10QlS6Ud4l7ZGDPw5NUcIDWN5IolO
         2wqh8TQEapKpb81s8njncdPx4BjO+NU5/71HkSHx0NFe3vKTRvwVCQK6fYztcZh28m/o
         Ox6A==
X-Forwarded-Encrypted: i=1; AJvYcCUCMhQYwOu17m7XaDqYtpDmZqOq2TiJ6rV0PNqFOdyNjFjNc2Olb3jQLMo/bRKfQubEuYzJdbw1pGV6@vger.kernel.org, AJvYcCUrFoHw5jfp+Shl/ZVHxxb4ATSLR5UOZ1RlG+o6ZmbBOMfVwTVnE3WoykO6L18yDLrySL1shNI0WNz+Iofn@vger.kernel.org, AJvYcCXS0xUfXra6zvHiDyoDyQc9YN+ceTm2RV1NSlueQPx9lNoyDB4FrHXivbDqVx/2LIaJ3/WwVR0vQnd8@vger.kernel.org
X-Gm-Message-State: AOJu0YzAImD9NXPLnvYntRnHZq/xqklAABrh108xfAWDTd5g3INs0JO7
	aQU5CqEbXg6uVRHxe4yBsh6WxssvVjwnzmT5EKPbO5unVEbkHl2OucgSEi+O
X-Gm-Gg: ASbGncucipNvPoTWAGpf8D6EPavj2US84uZZzqNKQcHH6W5DYkA7BwuDAJp1JDJ7kl/
	ejy76bwTCQJwGuiuOmSeIKC2cVwxvolLsgKjiZ4dLfDH6NFwThHFDm24vqxuuwPoaV6BX3B01VL
	B/zi7P1DRzN9422ha7Nk5MtwbjU325Kqben5WViTB4ssaKrLEvEo6/HkMTggfyQJ2mV8vUoTeqv
	CT9krEZT4/xT+qUWjnZGQFKRGc2FZpOwj2OESCQeWf67n+LBGUkDP/yxGMPaZn9FI69Vu41X1FZ
	e75z9xzNbGpWKOcOnb9/
X-Google-Smtp-Source: AGHT+IGGM483aG3Bp8D5kBJdaPBAlTB8/DN02NIdeDv5sC02gYcxe2bScsD3xDcZD7pQj6HVzirvFA==
X-Received: by 2002:ad4:5942:0:b0:6e8:f3ed:3f21 with SMTP id 6a1803df08f44-6f0b74f68bamr156935076d6.31.1744010555137;
        Mon, 07 Apr 2025 00:22:35 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6ef0f047c23sm54870786d6.58.2025.04.07.00.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 00:22:34 -0700 (PDT)
Date: Mon, 7 Apr 2025 15:21:59 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	unicorn_wang@outlook.com, dlan@gentoo.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
Message-ID: <j74t2zqvoslo5fgmea4kp434tafgchkncytofj65zbbt7ivcqy@auboc3pkdiz3>
References: <20240501083242.773305-1-qiujingbao.dlmu@gmail.com>
 <20240501083242.773305-3-qiujingbao.dlmu@gmail.com>
 <k6jbdbhkgwthxwutty6l4q75wds2nilb3chrv7n4ccycnzllw4@yubxfh5ciahr>
 <D8Z4GLQZGKKS.37TDZ7QBN4V4N@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D8Z4GLQZGKKS.37TDZ7QBN4V4N@bootlin.com>

On Sun, Apr 06, 2025 at 02:16:41AM +0200, Thomas Bonnefille wrote:
> Hello,
> 
> On Sat Jun 1, 2024 at 1:53 PM CEST, Uwe Kleine-König wrote:
> > On Wed, May 01, 2024 at 04:32:42PM +0800, Jingbao Qiu wrote:
> >> [...]
> >> +	if ((state & BIT(pwm->hwpwm)) && enable)
> >> +		regmap_update_bits(priv->map, PWM_CV1800_OE,
> >> +				   PWM_CV1800_OE_MASK(pwm->hwpwm),
> >> +				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> >
> > This looks strange. If BIT(hwpwm) is already set, set it again?!
> > Also if you used the caching implemented in regmap, you don't need to
> > make this conditional.
> >
> 
> I was testing the series and noticed indeed an issue in this driver at
> those lines. If PWM_CV1800_OE isn't set by something else than the
> kernel it will never be set and so, there will never be a PWM outputted.
> 
> Using :
>     if (!(state & BIT(pwm->hwpwm)) && enable)
> Solved the issue but as Uwe said you can probably rely on regmap caching
> to avoid this condition.
> 
> >
> > ...
> > 
> 
> Do you plan on sending a new iteration some day ? I may have some time
> to continue the upstreaming process if you need to.
> 
> Thank you for this series !
> Thomas

I suggest checking existing spi-sg2044-nor driver, which may reduce your
work for upstreaming.

Regards,
Inochi


