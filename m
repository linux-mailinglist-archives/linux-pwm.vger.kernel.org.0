Return-Path: <linux-pwm+bounces-2333-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A1A8FAC20
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2024 09:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22369281F79
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2024 07:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E99813E031;
	Tue,  4 Jun 2024 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlA+jcGy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44EB1EB30;
	Tue,  4 Jun 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717486465; cv=none; b=Dj6L+PRQfxXK6xGHl7XO6LTMgu5HCizYDnRDJ6YPo+9cBTcnsqkEDRT41MnHrCBQi4JHgUch/ox8a+7eRyJgToMB6lNOhtty8AI6CKefXuf6v5eCPIcmYtvEhNiXW7r5IyZZtFefGvzueU+Cp4/is4s/NADqb6EYYWHBbdcZj5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717486465; c=relaxed/simple;
	bh=xCNVkBcH/gmKgqevf9wQmZ5khKYNQcBbCO6uNuttAV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xj/+o4OxTPCSFpniOxiktGX8A+XE5JLDNGet8UDFfF/wVSlNiw6JI8qIQqmEMoC6DeT3TxNHXOmsTuq9VTY10OpJNZjRv8/Q7pG2EOwGzTwK0DJeWHGnc/L7J383AL903wwKPWw1273CKsI26QAJzdArABYnWhXj9ki+hr9Rbpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlA+jcGy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f62a628b4cso33751115ad.1;
        Tue, 04 Jun 2024 00:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717486463; x=1718091263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xCNVkBcH/gmKgqevf9wQmZ5khKYNQcBbCO6uNuttAV0=;
        b=GlA+jcGyzLPKO+InoA8tn7yL6ublTVmqnauBVcTEEeCj+jEtXGktPgqoH4bMU7yVf4
         fmKXCtxwMvOtxKvXoSTExbpbtFVHxxUQllbYs+NC4PxFQKBNRrmWBevVqbq0YN3L72l9
         wRHCmuSXsK9YIxR9CnJrzbfqhnhYLQ+9+34AAUhw320KU8Fbzg7mNz7EFTW/cNRw8aPu
         G9SOPv8bPK/Plbzsz00oYOdewEd/8hK7TGmGsFr/ywm94JX0lYbiBOc+H9KjiHzdtrUD
         IugvPpyx3ZbvM0l2D4XxdqT/mgFfempKkeYTmoQ8NnDLgDML/iDqMDQLeOC42iYoOely
         bNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717486463; x=1718091263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCNVkBcH/gmKgqevf9wQmZ5khKYNQcBbCO6uNuttAV0=;
        b=B+5kEQLQEaKlpqTX6exk2y7SUh/qbV+6kcYIaiQv3ygoFd9nNjBM2vw6nViQ5dodQX
         43948hvBF0aAuzFytUey7IJcAXE0+lWsdRnZ95N3E7X9fAAvEERKpfyUGSy/YKjnZiqH
         mlyFQphcKL9bLnW0fr9px9OCodc2kx5Y1H0Zu5WEEghSpIdSRXtzfMScyTKbqFpt+M+a
         4h4kr03lzcDD+fC6wa2Dem0ShG4vUfYG9yzlovAP4ROlTGgw667fV2KITkI5vBd2CzJA
         BjmIbhEZgH2olB0FddSVEfGB2wZzZ44z7CqFq+n1IsZxU8wODWqjELFRzefiCE1Rpukt
         0KBA==
X-Forwarded-Encrypted: i=1; AJvYcCVnCQcqcaybHJz8Y3Fm0qFPNcRtETTpg+88tdJignd+z7Xez+ipVG/X8yuFAnzZ/Vl0HBLYaMwZ4aFvI6X5Yi5koPaaQB/Ji4rjQP4w/80ALpp+llHJdw2KI6KMPOOKEaMvYdmiGG0WJoRXmNKavi2HqA7btLYnwEv93SmfvxLWnrI=
X-Gm-Message-State: AOJu0Yyk6zIiNB+YpEdlmD4D6U0CxtDztbmyO8LPUrutnbzKdeUXAetU
	3151kTy+2UMLURRousXCtgwPVKccB20PtFPm/zW+XS6Pk4iBHEMH
X-Google-Smtp-Source: AGHT+IHpMVkg3jI48lpihIrY4MUDqwpCT9ASKXusicQkxk6lGn9a8NUzjgHRv69bpHbfB1Rc73eWSw==
X-Received: by 2002:a17:902:dac1:b0:1f6:849e:4e06 with SMTP id d9443c01a7336-1f6849e5055mr39075135ad.1.1717486463007;
        Tue, 04 Jun 2024 00:34:23 -0700 (PDT)
Received: from rigel (14-203-42-154.tpgi.com.au. [14.203.42.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63232dd9csm77870605ad.58.2024.06.04.00.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 00:34:22 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:34:13 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
	Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Stefan Wahren <wahrenst@gmx.net>, linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	Nicola Di Lieto <nicola.dilieto@gmail.com>,
	Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: pwm: Add pwm-gpio
Message-ID: <20240604073413.GA137333@rigel>
References: <20240602-pwm-gpio-v6-0-e8f6ec9cc783@linaro.org>
 <20240602-pwm-gpio-v6-1-e8f6ec9cc783@linaro.org>
 <20240604025137.GA107618@rigel>
 <1edbcf6d-92b7-4971-b8b2-a88cc96995e9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1edbcf6d-92b7-4971-b8b2-a88cc96995e9@linaro.org>

On Tue, Jun 04, 2024 at 08:21:32AM +0200, Krzysztof Kozlowski wrote:
> On 04/06/2024 04:51, Kent Gibson wrote:
> > On Sun, Jun 02, 2024 at 10:33:08PM +0200, Linus Walleij wrote:
> >> From: Nicola Di Lieto <nicola.dilieto@gmail.com>
> >>
> >> Add bindings for PWM modulated by GPIO.
> >>
> >
> > Shouldn't the bindings be added after the driver?
>
> No. See submitting patches document.
>

Hmmm, ok, so "5. The Documentation/ portion of the patch should come in
the series before the code implementing the binding."[1]?

It just seems odd that you document something that doesn't exist yet.

Cheers,
Kent.

[1] https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html

