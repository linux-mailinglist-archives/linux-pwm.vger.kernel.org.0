Return-Path: <linux-pwm+bounces-3970-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B50AD9B5D22
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Oct 2024 08:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C46C1F243B9
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Oct 2024 07:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE581E0B96;
	Wed, 30 Oct 2024 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5FIz6fJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D441DFD8E;
	Wed, 30 Oct 2024 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730274147; cv=none; b=n8019ZGPCemp/DWqce5E3FuN9DTa8wjIK1FrjNl/uGoskGPo2ray0GEK0n2fygz0PjTnsJ/5l3v2GHguFAfP/Kfc6LjFBSRoSM4D1urOVLHnDBLb487eCFkwSv/IMDRLjGHQ4L6mRl2JL7aJ1ZvKBhAwTJNSfH6j5Zvwq29BSDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730274147; c=relaxed/simple;
	bh=vBPcXotyGZ/i5JXyF/OdPr9Pqo7sjFrngRcld4peje8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRMFi9PI6MFSt2NDD+tOMiE6WmqkYoFk2Ar82prlQkhaUY1ixsodnJJWV4vA/cIQfZLs1Fq45+OLd8ruamHsK8nbPXi4MhRMzSpvfozthMfm4cpvxWqzAJiE5SzOCtpnA+uAGFe2UekdcrM+kUft2XL0r39gvvkLAw7SppU65r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5FIz6fJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso59398325e9.1;
        Wed, 30 Oct 2024 00:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730274144; x=1730878944; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F/obSxVgLXYAZ3S4bATKBujgO8U8oWR6WSGb4BNz1Rc=;
        b=g5FIz6fJTW0gjCBWvAg7rj+Qe5PVTzyIBgX7WLvy+lTnoZR2VpU0BoruRAwDJ+Y1kp
         /vrt/o1qKRZyUxp52ZkidoKJhh/jdmPRQV7PuGDyjEZzxed3PmdLbdMR7ry7FucIoZtY
         RClT1ESCbsN3OrB/QWUcmrPlrxikZaQlxhtzJhhsdvXxYU0/ZiZC1hI8k3RAhymTMk1j
         MXOiqXB3LmXYTiihe9sqoqdVbEuT0CaNyAbG8eWB/p2VvyFzp8loO32SdV8oBeTbb10K
         eJZGLwEK7xbq7MeXhrSQwLL8wZSwTKzCK5LZUrNJGOAF6b3CNqix76TQxBYd0Vx7Xx33
         KqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730274144; x=1730878944;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/obSxVgLXYAZ3S4bATKBujgO8U8oWR6WSGb4BNz1Rc=;
        b=O9UviuLrAWyd2YHs3ZoWHgROxNkMjAmA0eJou24yT0DMXuyOSOeLwuDt/wqYmciNcL
         O3yqebdzhJ5aj9a+oiTUtUNZbl2Kx0MDhsAe1FU/5i8SOYQ4xjQt77nyBtz7CV50q/M7
         uIfisVIDb4Ce7nSHcrM7v8GkFV1DoQJeqcA4CO8/Kt/KFYfJ7m6FPhgKgQtj77IrunC6
         I22d54upLwoLHhxdp7RTIaxxzi0vtHUprm2AnxUs4Wdyk7IFrHqPjd9Kjr3K/naGYJD9
         UpWxRNUIjD2qE/cCvnp0yyFjNIb+1A2Zo711RU2l8njBZXFem1f9kMO9QnY7C3Pd5xQx
         kG/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUC7+iI0zyEu+6CcLCdUwahutecIBoZlfQsOjbnYjcfSzC+rsLVskgVFWEE6eAgmG53PYE9rq4Wdbx4@vger.kernel.org, AJvYcCVS+MKL1UraOQ1D+jURzZpi6FNUZUZZdtAROwnWB6bl8yS1TfihAzTMS+F1wGAmvhBwhzVN22PewgY9jw==@vger.kernel.org, AJvYcCWWeiLYmvXaXiMAe8JpDs0gm/+/es2xYNrhxaE1FuGK9iyOipg7HUA9IP6WgTD+6gr8v0RahYJS9t7l@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhp4785s+WAP/qOH3PZTD53lMYsiTr4SBuvgmq9+qsE0DxIZbR
	yXf544/2FAgp75pH27F1N/uZTL5407ut3KkGW+1SyVvkCRdQ5uSO
X-Google-Smtp-Source: AGHT+IETsV7UXMLp399BinpD0w900qG3hOgbxpUxgRBwxez5FYrcNIGJm85eQ9FYoXQ64YlW1Wx4Ow==
X-Received: by 2002:a05:600c:4fd3:b0:431:60d0:9088 with SMTP id 5b1f17b1804b1-4319ac9acedmr136064005e9.13.1730274143634;
        Wed, 30 Oct 2024 00:42:23 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd91096asm12658425e9.13.2024.10.30.00.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 00:42:23 -0700 (PDT)
Message-ID: <6721e35f.050a0220.b8d65.2cd0@mx.google.com>
X-Google-Original-Message-ID: <ZyHjXKFEqqbkJkHz@Ansuel-XPS.>
Date: Wed, 30 Oct 2024 08:42:20 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>, linux-mediatek@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
	benjamin.larsson@genexis.eu, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v9 0/6] Add mfd, pinctrl and pwm support to EN7581 SoC
References: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
 <CACRpkdaEQYBim8TuDCCw15QDUWhHC-VqhGq1Le7eOd76k56zwQ@mail.gmail.com>
 <t7i6lkx5oedjma6uauiygnvbgzixnsqmolmkse3j2qiy5znf7t@kfozote6mm2k>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <t7i6lkx5oedjma6uauiygnvbgzixnsqmolmkse3j2qiy5znf7t@kfozote6mm2k>

On Wed, Oct 30, 2024 at 08:34:01AM +0100, Uwe Kleine-König wrote:
> Hello Linus,
> 
> On Tue, Oct 29, 2024 at 11:03:14PM +0100, Linus Walleij wrote:
> > On Wed, Oct 23, 2024 at 1:21 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > 
> > > Introduce airoha-mfd driver in order to load pinctrl and pwm drivers for
> > > EN7581 SoC. airoha-mfd is needed since both pinctrl and pwm drivers
> > > needs to access the same memory block (gpio memory region) to configure
> > > {gio,irq}_chip and pwm functionalities respectively, so model them as
> > > childs of a parent mfd driver.
> > 
> > OK someone has to merge this and I suggest that I merge patches 1-5
> > (all bindings and the pinctrl driver) since the different bindings have
> > dependencies between them.
> 
> Fine for me.
> 
> > Then Uwe can merge patch 6/6 (the pwm driver).
> 
> The pwm patch needs some more love, we can handle that separately then.
> 

Thanks for the feedback, so I assume we will detach the DT and PWM
driver from this driver and handle it separately.

-- 
	Ansuel

