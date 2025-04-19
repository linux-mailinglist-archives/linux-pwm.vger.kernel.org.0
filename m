Return-Path: <linux-pwm+bounces-5574-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A96A940AC
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 03:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07AFF446B84
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 01:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60297080E;
	Sat, 19 Apr 2025 01:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQQQZs5b"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476D33C6BA;
	Sat, 19 Apr 2025 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745024518; cv=none; b=nUd/Zhc66qM5lW7caeuheKgYA+/Q+nNH9wHHKsTXW+4VAjBZie0DAfp1N0B6/4C3Ubr/arMgsqef9gZkSuVVwX3H4QARQk5jT/KWVh/gzHXcmMYGhf95NKNirscVqUtiA90BO/8D6swBzoW3zxlh9HlIZh/misgGnCBK1Nxa1cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745024518; c=relaxed/simple;
	bh=mwx8+qlWcBVd/c0rg7GGsFD2kt1ft438nzJO9RD5/Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3BDM1zmqHYYoP3+uwAPL6a/UVlYj42PPIkfZscOchpfdHw8kzNiQES7zRh7YehH+TMgG8fGHKpqIGHglul0XwdTV/2E9gARblsuBTUvw2zfGePxG9tSKGrGejmINGGvKJjZRv4Crsw1qX6JBEIpjQI79NngvtUAhvXVruzBRJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQQQZs5b; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so2281831b3a.1;
        Fri, 18 Apr 2025 18:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745024515; x=1745629315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ujUghSXI3lvU/j4kBychDVllaVMcrvSdA1dMJsQgYzU=;
        b=jQQQZs5bt0NIhM/x9dUN/PxqpNeKimqCUZejlfyb6jdy5YcQhWszLgCWuUdQ1kXJI+
         SgkKE1FWXag1raKDck0YVdAApK2UQPha/4hGBJMGelJyoWmZr/L1W4/FnHmC7Gy968zi
         Nn5P7+xnGLJm0rCjfSRCYFQqQH0GhEbTrJc1iPOrCN6VcUnY8smaZRuqBJ7uFg+L7iqI
         MkC2U88x3nR3CYlxe1m1pQyhQg+2kBtkjgIKxD5AozgY7AaewVsmy2Tz5oAUNawOBPiu
         YpdML85KJusfRXvsvCDWcAOguFG6ZetyQRfFo1QDEjQRqWUhOWUdqIjtXdKSLDlVkfFN
         BaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745024515; x=1745629315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujUghSXI3lvU/j4kBychDVllaVMcrvSdA1dMJsQgYzU=;
        b=Tf6meXYA1rhXn/AL5tsnxPnzB23Vp5Pnby3s0O9aIrE88PhF8lCPXBNKwoAgcznsRY
         kiojjCCn//hCkC+yKRJwwAYdAiSIiP1rQATOARo8yxypfKltbrQXYYfEjYPEG4jMzNHB
         1lXAfjq9l2RhLnRxBVUi8En9ERIRydMT6ZXSNtqwuEPm+mSOK5XQUlTPTPO7F+u48VRn
         Ugsk7YL1c6U+9hlOXV9ebsBik8AtE7Jm+EjiLdaW+KE1g1Jh3O37dzZKV2rALYOW/jHK
         R3gCkh/3/eC2ndmIVXVEpOgAaG27J7a/XlyEauwCqBmL6KhfAlxX0zEtk8YKykp13I63
         o5mw==
X-Forwarded-Encrypted: i=1; AJvYcCWfW+qsKz4V1v+r0Kyb/39ifLUZQ5ojOoOGBLp8u0cN522ZM48ydJmJuU5mYj+XNHxEnrGhiA/rPaLICzCA@vger.kernel.org, AJvYcCWhxuzP8k8kXD463IOqE2ekXn5POegNsQmDx+rl/ASj7JXMHRBj02HL3mCNca7pFx4eq8nmd20rB1AP@vger.kernel.org, AJvYcCX7FSL0AoB6uAwN83Ou/iU5mmItoRaxHdjJBVLSbExCbXAITdhrVKagpOVzzeSx0UzYsuplMQ1LmdbW@vger.kernel.org
X-Gm-Message-State: AOJu0YwpEMeicIIHNwkN8TRqIU4lVBGL9bzXAaTccgE11aJ5/Zk277cG
	CvSDb9BvE13SXM/qaWd07DXlmqR9Bd/7i89ahFdgZqV2jGW9DmzV
X-Gm-Gg: ASbGncvmEI5OtQwznyqYjBA7KzsmbUM0mShd55ltcyAcz16CbJkUojAzROk6XAPQ4Ta
	pQrzzaDJR1qyiF+XrgN8gsBZZUl0j2KwUGYSRyjuaCyzKmBNgIrp8XxSiCCGnPCLXuPch3XoE8+
	2yFTSzeQ2Wsr9Oxi9piSWCry3hT8K2A5dzVsf9aF3KHOA+FiZna7Zi5/iOVxs7uoP69pqOCUyGK
	efdKFniu+8fxVabXhjsQFfJMZ7sc06KJouJzhILYVrG5ZhodUwkZYpWXN+Gbf6KAt1hO+nf4a1p
	dFzEiV+MDaftyeJ6yhxJSy4v2zaRjs3HGo/d8K73Vw==
X-Google-Smtp-Source: AGHT+IGQtEfItXobFcuGDvqDRwlUvs2hCkTSpl7TA3j+71VHIPX2W4+6Y8A6gmR3Z+xQLeYoCXICrA==
X-Received: by 2002:a05:6a00:4acc:b0:736:b9f5:47c6 with SMTP id d2e1a72fcca58-73dc1566938mr5879716b3a.16.1745024515391;
        Fri, 18 Apr 2025 18:01:55 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbf8e3d4asm2248487b3a.70.2025.04.18.18.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 18:01:54 -0700 (PDT)
Date: Sat, 19 Apr 2025 09:01:52 +0800
From: Longbin Li <looong.bin@gmail.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [External] : [PATCH v2 3/3] pwm: sophgo: add driver for SG2044
Message-ID: <telzh74wfpenbhtpnkd74hfoqt3fens35xvftgng3agvaj3xoa@geocy2uc5nfs>
References: <20250418022948.22853-1-looong.bin@gmail.com>
 <20250418022948.22853-4-looong.bin@gmail.com>
 <a0d63c0d-7f17-459a-9ba1-6532a986c8db@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0d63c0d-7f17-459a-9ba1-6532a986c8db@oracle.com>

On Fri, Apr 18, 2025 at 08:41:04PM +0530, ALOK TIWARI wrote:
> 
> 
> On 18-04-2025 07:59, Longbin Li wrote:
> > +#define SG2044_REG_POLARITY		0x40
> > +#define SG2044_REG_PWMSTART		0x44
> > +#define SG2044_REG_PWM_OE		0xD0
> > +
> 
> please use lowercase 0xd0
>

I will correct it, thanks.
 
> >   #define SG2042_PWM_HLPERIOD(chan) ((chan) * 8 + 0)
> >   #define SG2042_PWM_PERIOD(chan) ((chan) * 8 + 4)
> 
> Thanks,
> Alok
> 

