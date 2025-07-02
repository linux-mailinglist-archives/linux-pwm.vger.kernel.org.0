Return-Path: <linux-pwm+bounces-6707-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CF4AF63B7
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 23:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767B717BF85
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 21:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1461E9B1C;
	Wed,  2 Jul 2025 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlmPAFZv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076172DE6F9;
	Wed,  2 Jul 2025 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751490313; cv=none; b=EfA1IBaNmoaPTG0BPnxxJrGA99uLuyzvLn/ALz8rMZHM1lYqGVGFzQGlknPkqx2mOIYkwNd1ZATeNK8zDv0sog8Wd+uBzImfag7YouJOieNw1QVIqNnTss4B2g5Z0ApumxbbOHeQrlqpYVU2V8m1XDpeA37t3mfVtv0avptEFug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751490313; c=relaxed/simple;
	bh=YG6sPS0G+I71vksxn4epGkUMjbDGBdqbdGVeWWGjEjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAq/xuUFPzbIJJm3D3YUz8DctHyjadC1Y0mrSOumMYtMJC7sLBWZdom4OM1DAbwv+5oHB3tz8se3E7IUjU4ZVydOeYSIUCKpK5UZ1d8jMC3dn898hmN0zxj62Cet8l3+6AJY/7Q/6NxB73upuhqcr+JIppcldBWgSuyMGoF58uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlmPAFZv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-236470b2dceso42712775ad.0;
        Wed, 02 Jul 2025 14:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751490311; x=1752095111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wh2PtfxFsXVqWIGJhK/ssCsDM+Xukv05BNpcs9NLP9I=;
        b=NlmPAFZvcijlbCuhBELwDijrRXmTc+HQFPC/47TpiwehITCPDxVA3PqnDipqUXExiZ
         V4mZVA2puHDq5xZtpfxegx1yjtbHM4ZNiE+3NjXh3jbXIexb9q78VjQszoZQ050cNSlE
         ScUhBMKAL+3sz/xW5Ujavbk1dCXpmLS2bOpSbL+T0MYCI5zMb3GMN5XbPpIkWsDQexEf
         +p0KbRAAnugxhtUnyBl66FDDY3DkOKicpCvBXHqpvTOD8WKQtRwHgFe4q/OrCtutnnqd
         1rKELVfMbQssv9l2NHKoS12IXnO/rF+i+ssCbgoOkGSR8Bd25P/3bTL2qNeZ2oOioKlm
         T6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751490311; x=1752095111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wh2PtfxFsXVqWIGJhK/ssCsDM+Xukv05BNpcs9NLP9I=;
        b=VZWNrLdWNBOYec343V0jTzZpJZc4mIqU450lLCqLxLe4R7a1JtcPtha6/b2F/oV2b3
         bS1VgAr4/4E7VL1Gu0r3BNhsptMkb0c3ZntrGLGFz+QoaOdVfglnq5woYFycGkpNLu/u
         XtdKTuOG4w2NZuj4ha1JwTKAotcZWSv405xI1PoPWs2LrbIP4z9AxTgM6syJsfuNOC85
         0coK23T34gg4l4riQhjY5P3j0zLlxP+Zxjj69Ye6QtbEyHAF32nGxVYrM6AdJWEbprzs
         +LHCtVIaCaoFf07q6qmpCcGTCHWsYfx+5fAQyPxeaYD3YT1kGKA8v+Ff0TvUqHCgr7Zz
         RYdw==
X-Forwarded-Encrypted: i=1; AJvYcCUSFCWKiuDnL20ckUmCSeYqERBRO1TcYpDn1lL9w+f/ETs3S7usZbQ6VOVRcIRwTu8n4+2xOoNYyTuj@vger.kernel.org, AJvYcCVBf7uz3ggCBG7CW20u0cEvO8QpZaS9hHUu3dRj+5+fIU1Ov5ty0RtzdS1GMrKkox7HEOx9Ybc+fSQRtw==@vger.kernel.org, AJvYcCWY7T6r5vnN8Ioc1jmo+JRUUU5UFx1B1nStS6MwwqZMQ3Gh5hs+mG5snHBJ4vaIbi8YJ6BOQTeGqjxhXJcd@vger.kernel.org, AJvYcCX/33PxYvrgDFyfzoHE1vCpc66kR5DOhQyr87ojGIHQdIf7w2IRNydBSqmfL2LtuRMHyEejwqcCAcKo@vger.kernel.org, AJvYcCXnVqLsx5o9Q4321TfEwccOMu+obPQdZWlgFYdbt7dAcaWk3VuhYCLHqfZORZ2xOg0j6l2tRe3nKj3ZDZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5irhQ78EB8mb7UHUgt9dkOuagyGwTb2jNFXhjJZIBcoG82AAh
	pyy7rL5oVj29PbjWpbJKvr3yMFeYXwpsAfdWPMBSCWIsuEsJzXduNGqk
X-Gm-Gg: ASbGncvvhMgHH2boXRpfXrMqJaQyOPX5lH8D07DnetMgNMVP+Jzox5/Zp1m5ktB1eN9
	Yy2X1XTLeIDWsPkeB72V+H8+jZ/7TJYQrrsDnLMe4St+55p5dldpHK69G8JtGQ3j2pdQN2WatGZ
	TwdM72XnRE9zAnFCG1WZdVjRA8laSFbBLZvXmZvMlN2zwQS6hKUW2otPEVh1GCR6NUkTnoVchLe
	8gSMFtRQ/5JE04HJrqdn5QT4L5cQLjw/GOJcQdtO2UxDmuJPkEJKaEh+T6wkRXiOCBlfgOYPklJ
	1tUlQhlBYSc2jbAp7Nq5fSCMA6jMyXwLle16eJgV8OCeRWwovPiLdpKYSWSz/rI=
X-Google-Smtp-Source: AGHT+IED4rigsUmACCM8UMue5pRAk+uyxupiG5Exv/rXBrfmLjc9Y12VetS1nwj6oMIn6YZGh8phpQ==
X-Received: by 2002:a17:903:1a70:b0:234:cc7c:d2e8 with SMTP id d9443c01a7336-23c6e5b0fd8mr52532375ad.37.1751490311058;
        Wed, 02 Jul 2025 14:05:11 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:918b:9ece:525a:9158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3acc62sm146106955ad.143.2025.07.02.14.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 14:05:10 -0700 (PDT)
Date: Wed, 2 Jul 2025 14:05:07 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	andriy.shevchenko@intel.com, =?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v10 10/11] input: misc: Add support for MAX7360 rotary
Message-ID: <rfxdncj7o6ow53jthveea6byresoz3vwts3h4cqjezn3egrny3@sd63xrnhwm6s>
References: <20250530-mdb-max7360-support-v10-0-ce3b9e60a588@bootlin.com>
 <20250530-mdb-max7360-support-v10-10-ce3b9e60a588@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530-mdb-max7360-support-v10-10-ce3b9e60a588@bootlin.com>

Hi Mathieu,

On Fri, May 30, 2025 at 12:00:18PM +0200, Mathieu Dubois-Briand wrote:
> +
> +static void max7360_rotaty_report_event(struct max7360_rotary *max7360_rotary, int steps)

s/rotaty/rotary

> +	if (max7360_rotary->relative_axis) {
> +		input_report_rel(max7360_rotary->input, max7360_rotary->axis, steps);
> +	} else {
> +		int pos = max7360_rotary->pos;
> +		int maxval = max7360_rotary->steps;
> +
> +		/*
> +		 * Add steps to the position.
> +		 * Make sure added steps are always in ]-maxval; maxval[
> +		 * interval, so (pos + maxval) is always >= 0.
> +		 * Then set back pos to the [0; maxval[ interval.
> +		 */
> +		pos += steps % maxval;
> +		if (max7360_rotary->rollover)
> +			pos = (pos + maxval) % maxval;
> +		else
> +			pos = clamp(pos, 0, maxval);

Should it be clamp(pos, 0, maxval - 1) by chance?

Otherwise:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry

