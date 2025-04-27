Return-Path: <linux-pwm+bounces-5725-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E757A9DE3C
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Apr 2025 03:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845A017CCA7
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Apr 2025 01:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4CC22068A;
	Sun, 27 Apr 2025 01:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEbK4uQe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D351E7C3B;
	Sun, 27 Apr 2025 01:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745716080; cv=none; b=tgttTkfrqe0ZoPfzlMQns/7Kd7tc2HQ2mGjoZWP6PLyPIcG4k0xsibSq9D+BNgY8BaG+D7iY2jwQ1vMtrOM8ywI+6QmqZjeQWA2RtJ8LeD5g4uydj+P9e3dAe8P7U68q43TR0EnQWkxoSQLZSP+ywJHSmcTmw1h3xvZNVeyvQ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745716080; c=relaxed/simple;
	bh=Qz3H5UonH+F0Ejh4eB3KlmRFyRFKO6k4cPWFEyvmaN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGhXwFwuvRmgRTGjcCKbQf5GTip2LBamUtoKdG2fGcvok7J7B37bgMhaAxCv/SeKRacdv1Ws7qxZ2Qd8X9BplmmRCqAvTueeaYH4fxDNqAtdMwhhGxO8H5npYwL8qHQtp5yQrROEN3eX/f1GRbqp/qpvvOUp0SwVOYFNOwrLuAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEbK4uQe; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-309d2e8c20cso4359344a91.0;
        Sat, 26 Apr 2025 18:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745716078; x=1746320878; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qi/DM2NVeWE17m30+tFBeykLvgqkmQd+TLzeOQAEaxA=;
        b=SEbK4uQerDat63CCQToLjN/BKwcCrBlyZhKkntZHAEsw91RLfx9WQ61yrelaZ5flIH
         q2uAKRKnN1mB9Ud5z7qUfyXjv1sUl+sU+XzF+dM8VFLf00vG41kqwxeh8DrnFW88gMyS
         1CFr1Vz1IOOq6IR5tPOm0wsZlD3ksCfgeXNoO1fsfyeMHKC2l4719zykGYNLMraKudSW
         zQLWIj1+jiqEiHtO2iw6vMHuD8csitncS+AW9lcPJkx5m9cPhY/vID88OrufacJHgncB
         nL6jpwFXZHK/D11SWXfoXEJ/Qp1/e67NeRYjLjx5Ue6Pdj7ZbHd9xUu+i/8NhG7ZwMyj
         YnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745716078; x=1746320878;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qi/DM2NVeWE17m30+tFBeykLvgqkmQd+TLzeOQAEaxA=;
        b=lOMzl5hHDgTz67wJviSPBM9cDqvF42PkHk/pfpe1Ecs0j2A+67zdGa4Yy4ATbpkVRx
         xnezuGEgk3pfoSgi1Z8qkWm01BSrG52A2M2tFY8OdXLxrdmmer5FS78k5s2mxzLILK/6
         N/cyNR1IuO6AayPDL/VCZaEwUnLb/NqPJAeLoFRxtxNN1O4foUQDtqJCEDMkfERYX7pB
         9kFyeHDqgwATg5XejE/RnJDv8puW0k8r+tVkbSjLeaYmFFIjdG1cQPnL6B8s0P+hSoZ+
         LH2ptxN5RzK5G73DFoYhtR+2uImjMVfIsdbaInmHXor/0tf0nfNl3jLrTveLmVTmwFg5
         uEUg==
X-Forwarded-Encrypted: i=1; AJvYcCUe0LQcDqCO49NS69vpyFdOxSzaz6aEYMyY2t71W3j2j4pqHdNS3c4yTmfD84hp2TadZnwp32v9YdHEAA1/@vger.kernel.org, AJvYcCX2Gz+qbIdolAznByPD770IJHz+iP5odn3lggvV/FwAgZX/sOQ36jUNlEY/geH1hj+04rajOpzQFcR/@vger.kernel.org
X-Gm-Message-State: AOJu0YzXZgvcbzlfeX7ujn6r6zGlY0HdlLliW2MXXCcstVYwlwIxXo6F
	j+ncuguch6rhXms4bawgzPAX+YygBInB4htqcqlt4hIgcHUqNef2
X-Gm-Gg: ASbGnctcvFRAZEkvmerquJV27VDU1Gd01+WVBjvEQ6F1XJHAmHTR/u5XGqBk1lD1iTq
	7f0bo6/c65fCGlPlscZtd8nAAvpyw3ZNwY0Arc1JY47DcAnFuO3lmLX3qjnUTi8gVhFRZhQnufZ
	AEWWgKRiMXAXOxDBE8UtpLCn3DDrUMbFV4oFLaWFyCB3LNWMs2b4Yg3tQkdDxFyWqZzhsIER200
	rwSlkzJt39MQrrz2gfnkYVjULuPKrSsa/XmRX8vgu+oUl4IizI2Nr+oiAkMoiFzIVuji4wKWwqE
	OdpkKbuSnwxYOKWtcXHhao4fCl90H/5jakNntLi5Aw==
X-Google-Smtp-Source: AGHT+IEOE2HNR8Z62iAJd3A4G+i2avNNhNGvpebOOqlr1I5tJlN3/vtrc9yI9fUiyGEU1soypp/xSg==
X-Received: by 2002:a17:90b:57c8:b0:2fe:8c22:48b0 with SMTP id 98e67ed59e1d1-309f7dfddc6mr11264812a91.15.1745716078381;
        Sat, 26 Apr 2025 18:07:58 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-309ef1475ccsm6041086a91.44.2025.04.26.18.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 18:07:57 -0700 (PDT)
Date: Sun, 27 Apr 2025 09:07:55 +0800
From: Longbin Li <looong.bin@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v3 0/3] riscv: pwm: sophgo: add pwm support for SG2044
Message-ID: <efpbhawsfg7nlp4waxtp366bemzzoznpoikob4ndzzoibs6n3d@6y3jdfw6zrhi>
References: <20250424012335.6246-1-looong.bin@gmail.com>
 <MA0P287MB2262EA042510853498EDD60CFE872@MA0P287MB2262.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MA0P287MB2262EA042510853498EDD60CFE872@MA0P287MB2262.INDP287.PROD.OUTLOOK.COM>

On Sat, Apr 26, 2025 at 03:25:18PM +0800, Chen Wang wrote:
> Hi，Longbin
> 
> Seems you missed my "Tested-by" tag for v2.
> 
> Others LGTM,
> 
> Thanks,
> 
> Chen
> 

Sorry! I will add that, thanks.

