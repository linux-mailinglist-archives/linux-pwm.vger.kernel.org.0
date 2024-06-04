Return-Path: <linux-pwm+bounces-2335-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0508FAD4A
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2024 10:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB3B7B2102F
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2024 08:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430561419A0;
	Tue,  4 Jun 2024 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmvYp/VX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4101420C4;
	Tue,  4 Jun 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717489003; cv=none; b=twUNLBEE/0JDS67aMXdmuPW++F/ZlZKarM2iQkZyvHtRYlsOse8GZHMx20t2hC1wneKNB+jKnXFZKvC4A1tDDc6z0zyMnOg6PmhE69YwapII7Rl29Zp6090HjMkCTORXQJNPFNSc9vQrTrN00Wrx41HI2cIqcT9ZPnZmAlMxlw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717489003; c=relaxed/simple;
	bh=RF1de7l+mbH6XaDixDWUqHPoZdRvLsGqDkhNGsBKAWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hiy9tk8WJjl0ZmXzK1R2Hf6KJa65B1CviRxrfHD0dNYWdZCVrGzFR7240ca+XxcvMeEsX+8tHxIsZLtdmImvDAQI4X66e0SvnpPx1wCVHvHk0y36yA2KFPgBcuCFLxumeA/9u3zjTZzhyS2V+faGVzPj2fZ3oG2GXH7VZCD/Me4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmvYp/VX; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6819b3c92bbso4191063a12.2;
        Tue, 04 Jun 2024 01:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717489001; x=1718093801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RF1de7l+mbH6XaDixDWUqHPoZdRvLsGqDkhNGsBKAWE=;
        b=AmvYp/VX0IVwWTTa8ZaeINtMaSsd+08uf3/3edbbRsUagGgOKbu/VEjIjbgRMVzcap
         QZuFAb/moM9jT50Mf7KxGE9j3Yhs7yceV0JhN1ULpeT8Pepgug2CARN4CzpETDjm051K
         5M6PKtTL9wi1sscNmRK7H7OShdgeET6wmVy9XqCn0p2sXQqVRibV4dCVlWitkkOPKC4Y
         mHXSDPxk7MPgJkrEPnUMQgL/cHEyHNE4flQvIZHz5onbJTHUk06MdN6P5z8g9k1KHN8M
         u0M+pDn7LXx6hMK/PP2MjHzNxbK1Q/icFJdRrXlyd3NM7ow3myPf8S6WsKqxOwbZ1xm5
         KVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717489001; x=1718093801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RF1de7l+mbH6XaDixDWUqHPoZdRvLsGqDkhNGsBKAWE=;
        b=GOD8SeQtM76XzNqQ3Ffkr48Dk/kBKLA021VVJGeg1Z+DFl8PrEyYWIGAMSjr4Y8yzZ
         yZtQasUdeScPjRcj9U5bWUGyRNGwhfYDFGubZoYQgHp6zhbZFoYA9VSooDz2wloKezof
         UCyG+tkxG3rDWGhYPSveE9apYqLNyIBhmsIpCnSsedgKosZT/h/6w3C6DersZeokD+ZK
         FaZcDKj39CFNzOh7pti2AIShq6fFXFN5EOQT8deX0Fzm+G4rCtZ0fVrU27JkhM15l/in
         CoIEQ/0jMZZlduOc4aI6LxaYOyYfOrHARWAvFwMpRaUdqsyZcRRvvNseNiSV+SdBl+C1
         cUAA==
X-Forwarded-Encrypted: i=1; AJvYcCU7qaqWSAVL1eqv5U1GXi4KwGuyrQG+3RX29mYtLowImcrmOLBq5O+hAkZLF6oP4QReMk3677i27cxtSUHQE7pSJz+lz71ZOsWj7EiV9vvs/CVrPJOKDl3YBWw/5jlLH6NKvEsnk0Bu1ozs2NBbgVawssMHJrSWKonC7i+1S6T0Z3Q=
X-Gm-Message-State: AOJu0YwuUIDKJU4jOZTomK6Ym7Q6/Q0SLwffeAbRFbaZPKBYFcZJi1G/
	si3IpjE0o6tZVXVCYpN0wZwKLGDY084X+rWIzEr3fcLl9CMz3qXM
X-Google-Smtp-Source: AGHT+IEhqvetfGYxmlLW8fBIaw4jp9S3aDBSZ9uIp1h2Q96LGj51GBFhrK0Y8xh0hpksQQxMSnAjog==
X-Received: by 2002:a17:90b:4c92:b0:2c2:1bb4:f1a9 with SMTP id 98e67ed59e1d1-2c21bb4f28amr5879090a91.18.1717489001002;
        Tue, 04 Jun 2024 01:16:41 -0700 (PDT)
Received: from rigel (14-203-42-154.tpgi.com.au. [14.203.42.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c28441e5sm7494971a91.57.2024.06.04.01.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 01:16:40 -0700 (PDT)
Date: Tue, 4 Jun 2024 16:16:32 +0800
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
Message-ID: <20240604081632.GA147954@rigel>
References: <20240602-pwm-gpio-v6-0-e8f6ec9cc783@linaro.org>
 <20240602-pwm-gpio-v6-1-e8f6ec9cc783@linaro.org>
 <20240604025137.GA107618@rigel>
 <1edbcf6d-92b7-4971-b8b2-a88cc96995e9@linaro.org>
 <20240604073413.GA137333@rigel>
 <7679dd6f-c952-44de-8863-2f0fd12f372a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7679dd6f-c952-44de-8863-2f0fd12f372a@linaro.org>

On Tue, Jun 04, 2024 at 09:42:25AM +0200, Krzysztof Kozlowski wrote:
> On 04/06/2024 09:34, Kent Gibson wrote:
> > On Tue, Jun 04, 2024 at 08:21:32AM +0200, Krzysztof Kozlowski wrote:
> >> On 04/06/2024 04:51, Kent Gibson wrote:
> >>> On Sun, Jun 02, 2024 at 10:33:08PM +0200, Linus Walleij wrote:
> >>>> From: Nicola Di Lieto <nicola.dilieto@gmail.com>
> >>>>
> >>>> Add bindings for PWM modulated by GPIO.
> >>>>
> >>>
> >>> Shouldn't the bindings be added after the driver?
> >>
> >> No. See submitting patches document.
> >>
> >
> > Hmmm, ok, so "5. The Documentation/ portion of the patch should come in
> > the series before the code implementing the binding."[1]?
> >
> > It just seems odd that you document something that doesn't exist yet.
>
> It's logical. First you define the ABI for every user, then you
> implement the ABI. Do you first implement software and then design? Or
> first implement then write interface (API) for it?
>

I don't see the relevance of your analogy.
This isn't design, this is roll out, i.e. publishing.

Not publishing the ABI until the implementation is available seems more
logical to me. But as long as it is all in the same series then whatever.

Cheers,
Kent.

