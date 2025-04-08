Return-Path: <linux-pwm+bounces-5369-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C01A4A7F2B3
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 04:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388753AF3C0
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 02:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4FD1D47C7;
	Tue,  8 Apr 2025 02:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkKetjWS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ECF1A5BBB;
	Tue,  8 Apr 2025 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744079651; cv=none; b=T0Tm471PP95zSGFB6enMLJaqHPSjG97sYfCUfGgEnxYqeBkDhf+nzP9PemUcT7jXSMD83fJkLchDxAKecR9w/u0qPCoTzXUpQezjSMV5G/UxKHpz4vQCD1zKpz3+XmwMWnVDpEoNtvV1UfC04cmG73uYofBNlMBB3OcSLzk8FkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744079651; c=relaxed/simple;
	bh=+hLj8ICUAAVqQQcsCRHJOsDstttPzIFItann4SgbdTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdwYM9leJ/ubrrSe3ucWlPe8NWaZthLJqRAhNBqBITbpgotUe5jK38aNAAyA6YiwIH8iKLtUGu0V9Lfq87jmjPQ5aTx1BBguZBeulfLtb+atiy6dsntxw0DPXiohbVwWZy4nMxkK2QsFrWGJZOt6KEhuYNaXajYZLBI19v7nDKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkKetjWS; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c08f9d0ef3so303486185a.2;
        Mon, 07 Apr 2025 19:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744079649; x=1744684449; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=waaMzRcEYQgRpRjT/cb8agAmmDWkveY+/Tn+x5v2WbI=;
        b=GkKetjWSYHbzm/fQlyh7Dbt7eVpQWG3He0fWFjvpRKEl6K9QAQEgkirdrkG3fOeeu+
         946j698ct5N1444jNMyup7SJEbTyvxTTE+JzZs0Z5NyOtlJaFfykyK61c0BnkOB9/KYd
         ZVqeTDfMwoRnuvRFkZmld7KryaV9RJ24z7z6Butl1GtRGO9OkCzRqYr3bX8uebxMrpEZ
         2BackYStPHFPAZurkAxfHkG9Lnfkn2bHHdtvUlgBnIxAS4nPcpFImXMzk03Hw7IGKnjX
         zrlej2tsrwOeZc14UWDaqgE+vWNaQ2EGO1IMJQ4O8Lm4trTHlEuulGQA0RYOvhkALAT4
         OyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744079649; x=1744684449;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=waaMzRcEYQgRpRjT/cb8agAmmDWkveY+/Tn+x5v2WbI=;
        b=w3qvznv5zXVvrancwZG/94JZ9S5p4eryUS2Zw+wSJHDQYuHH7UvhTY1LeydY+fGQKl
         D9KNpWmBjq+wl2OJFaTBxKsX36NnNZ8DM+5o/2ZAQtpfBc2HGs5QbtM6PYGe18AbcEsZ
         8IAqlDR5vQzNty4inza+i4kdqjA3+KLlFTFU5NS6MPYnkwr1+PJKmvF7Bql1HXbYNmP/
         kCgHhgBnQGRR1Jpnv/OBLu6r+06OlwWgp3J1rf43f8EwlaW66PSr82Tc33Csj7f161PR
         n8HYBqR3O34NQ3EOtZAiq0Si7bxZ7MCVdTpK2nihHzBJGW/NnCmJPGPAO7nj/rozNq7Y
         NubA==
X-Forwarded-Encrypted: i=1; AJvYcCW2RNJZM6+GZNDekG/A4OVguRCwuaVpEnoGRqcVXC2RFzpwE1IGDok1ZdiHXKeg7bmsai38a5W6nYwG@vger.kernel.org, AJvYcCW5/XgNzXO8E93SZG1uAReghJWJp569G6n/AIg+1fdAfGsn8TUC1B4caPAHtoG9KEkCoLq7MlKuciJ9@vger.kernel.org, AJvYcCWLdUtf7wL9z3YLafEWqx7XBC2BA4jjQJYAl48WQuQYy0ZbvfJXKC2b+SFDmchCbLsO4VAaXcsgh4Y0gtMq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwot0VF95ubuJSrX9oZWfN4FH0mbkXyxIO11yjX3azF/9a9jH/
	k3rBFpaieZawLrLZQQNdQCvA6Q2eUQNM3z6KOnWw7uVOjeJmV3iG
X-Gm-Gg: ASbGncsTBnc5mZm+DvzIQkyI2yQFRwbtQo3ff9R2Oaznl+PmPmKek6IXPk9LI47DNNL
	rpz+Q5oklRCxUA1zWrOWgxs2q3xPMt0r3hLYoYyaYDGMEMQ5NGm9E6x9FUJPOfQo2GgySg89eWK
	HTsnhVLQo5NR+wEYc73zg80pVvVPvudCXt8kna6Lh3DIjftsEm03HZoYzrjQFYBz0778BSDFZ0N
	8juagCZ9ta2VfdTY01LrjUopjTwUFerTcOtp2gOOp1xVG+iu9dII4KgartO6ilPfY12bPWLHdaF
	XrawwaHlvPN65dtj4gu1
X-Google-Smtp-Source: AGHT+IHa2pjYh5qtU2xFWFpFRw710b9YzXGj/CQhpz4LU55IzIv/AkIca8T95g1vDXO/do3EzvlTyA==
X-Received: by 2002:a05:620a:372c:b0:7c5:a5a2:eea3 with SMTP id af79cd13be357-7c775a3a33bmr1702022885a.34.1744079648872;
        Mon, 07 Apr 2025 19:34:08 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6ef0f14d2a7sm67012176d6.107.2025.04.07.19.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 19:34:08 -0700 (PDT)
Date: Tue, 8 Apr 2025 10:33:32 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Longbin Li <looong.bin@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, ghost <2990955050@qq.com>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: sophgo: add pwm controller for
 SG2044
Message-ID: <3y4nm5ievsfyomyzm35b3moj2buunwmisjowmvovhbglcjwnhi@gaj7wz4sm7tj>
References: <20250407072056.8629-1-looong.bin@gmail.com>
 <20250407072056.8629-2-looong.bin@gmail.com>
 <jq55x7uhftvejninh56tzk32jtmmwa5wxzna5uxbkk5woi7zi5@6wrg2ctmyg7b>
 <20250407141119.GA2192351-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250407141119.GA2192351-robh@kernel.org>

On Mon, Apr 07, 2025 at 09:11:19AM -0500, Rob Herring wrote:
> On Mon, Apr 07, 2025 at 02:31:24PM +0200, Uwe Kleine-König wrote:
> > Hello,
> > 
> > On Mon, Apr 07, 2025 at 03:20:38PM +0800, Longbin Li wrote:
> > > diff --git a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> > > index bbb6326d47d7..e0e91aa237ec 100644
> > > --- a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> > > +++ b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> > > @@ -17,7 +17,9 @@ allOf:
> > > 
> > >  properties:
> > >    compatible:
> > > -    const: sophgo,sg2042-pwm
> > > +    enum:
> > > +      - sophgo,sg2042-pwm
> > > +      - sophgo,sg2044-pwm
> > 
> > Given that the sg2044 has more registers (to e.g. implement different
> > polarity), but the sg2042 registers are identical, I wonder if the 2044
> > device should use:
> > 
> > 	compatible = "sophgo,sg2044-pwm", "sophgo,sg2042-pwm";
> > 
> > Note, I'm unsure here, only providing input to people who are more
> > knowledgeable in DT that I am.
> 
> Depends if s/w only understanding "sophgo,sg2042-pwm" will work on the 
> 2044. IOW, will a kernel without the driver change here work?
> 

No luck, the logic for SG2042 is broken on SG2044. In fact, it seems
to be more familiar to the pwm ip on CV1800 than it on SG2042.

Regards,
Inochi 

