Return-Path: <linux-pwm+bounces-3274-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EC69793CF
	for <lists+linux-pwm@lfdr.de>; Sun, 15 Sep 2024 01:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803911F215B8
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Sep 2024 23:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AED413EFF3;
	Sat, 14 Sep 2024 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+eBfPj0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFED1754B;
	Sat, 14 Sep 2024 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726357201; cv=none; b=IpFvAye1kqojREzUCH9Mm5M5e7Dg4rIpfANNauwd+OJBgjGkTzjpet8m0onVx5Pb3nJVZofpy265PhUIp86lUwmbip78atg68cW5ir9VwlwqYEAkXvTbSPzL6IgIf3i7TEC9YkjOPdZF9irvmyqGWfFjRBAdwV3SDrShbeC23Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726357201; c=relaxed/simple;
	bh=KVrtqc69Bj/9Cl0nn3MSnykQQki0hTOXkBmMMqFTm+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9aUM2XiXfrnZXBQAI8PY4/okDytFPrNN4F8kQwPK+BFH0Tyb9u8X4q3cwnNqtFkyXB6rcgqJI2MjuZ3crsBHkzSN1eyBTYIOEBJWSFM/Qs3uLzm2QsZflpI+fShe5rF7m6hH8Vn2Hw/+3LRXL+SOVR0nIXhKPj0DVU/K3gCl8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+eBfPj0; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a9a23fc16fso346278385a.2;
        Sat, 14 Sep 2024 16:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726357198; x=1726961998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KNiLC9yIqzSFrDj7dhKEamKTUs7tim6by4sA4P0KRMM=;
        b=Y+eBfPj09QiFmPaN8yMZYVZKAJs7NvbQdl/DeAyOia0BDOuPfUKZa+V2ekOHdxu/rM
         LwNdiJC7Y0zkb8/YKeORc4ZFZDeJn7dmOHAu04TCW3vI2iTVLVUHO/rsdei7W0mhikuV
         t5t2DMwALckyqefZx5vFPzpv8KWmNQCoajNNJcDQhySiqMLQ9xmYyIBgRJwtpVJCk5ud
         IDG0D7AKyOL5XKEfatOS4UINNuDalzPjTy8hUyHREnNflT0aPuHA1J5MQTpWXAXt3rw1
         cter+BktGzfZzRXOut/CKPhNCH/5XS57aiq4GPc2eiQCFps77G0zVoHlfxEYdn5Xb5yK
         LOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726357198; x=1726961998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNiLC9yIqzSFrDj7dhKEamKTUs7tim6by4sA4P0KRMM=;
        b=OyV3hlVPXyI4/m5nHzZr+ELb8vAcLGDKnPqhMhhP/nryUL24QC4HcmCO8FjiGC7BhM
         c6O50bQSZqO64X1yjuUokdNoWjp6GOtlDjmlVw92Qmf3m5sunEfENoUiabFDvq6z6L3K
         FpoR5H/b3fLae1gERfeSrj66NXx43NWs74TkaTJaIkowg66xJ6RK+ukLBeD+tPpjNBat
         zfu7MjjHIQ+0VeCyhPX9uEylSkTW+OmJ+WQpndmDvZD8Ln1C8+NfHlX4Sy74xMLYPZVP
         R5VFWn8ZNAggfs1urzaaFqCr8EnL5rUuJhOsOwkCbC9lfPmotzU8pRXSE17xHBpOQtkf
         Sejg==
X-Forwarded-Encrypted: i=1; AJvYcCV9tWUf9CyRDTRzDnPwFtCwf6zz+uyGXAASXtXseVFJwpNWYrwuDx4370+d1TfN52pUXQzEGhvNCowv@vger.kernel.org, AJvYcCVV5IT2kt6AE4oM17pn0tScI+uXF5vn4BZ8mq1+vuoC4rtAY69p4iFnFL9bkHAon+zIR6X1f4YXigOh@vger.kernel.org, AJvYcCWjXME/6l2gdm87dftb9KW+mxrRU07bywXQAGmdAw7qb2t/blru1iejVd+MSqQGOA6hJrELOtcNK4xjHCyf@vger.kernel.org
X-Gm-Message-State: AOJu0YzVZE1HTCkEdpyg94Ldq7AN7BEnnrjxfDkkG2OQe/4WVqOOswVQ
	mqIEkuFaU3k7EwUCvO775sSSSxj5d4gHBNa3EUJ48Zy5rNZRdYIs
X-Google-Smtp-Source: AGHT+IFc0J5CoyQ8jeRWmCtEJ8yaJztt/TGB5Ou6Z8EfWoWRWpnOH/8UJPeuV8AFHaApQK4MhV6Eag==
X-Received: by 2002:a05:620a:2910:b0:7a9:b839:1e87 with SMTP id af79cd13be357-7a9e5f3d252mr1836226285a.39.1726357198429;
        Sat, 14 Sep 2024 16:39:58 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ab3e95e9bdsm112982585a.16.2024.09.14.16.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 16:39:57 -0700 (PDT)
Date: Sat, 14 Sep 2024 19:39:54 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Mehdi Djait <mehdi.djait@bootlin.com>
Cc: christophe.jaillet@wanadoo.fr, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 0/2] Add driver for Sharp Memory LCD
Message-ID: <wasfy7vwlvw2kikj4szgj6m4pdiqhmkub4g5jg4wop2nzb3hzc@oo6mrj7q2jt3>
References: <20240905124432.834831-1-lanzano.alex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905124432.834831-1-lanzano.alex@gmail.com>

Hi all,

Just a friendly ping. Please send feedback whenever possible.

Best regards,
Alex

On Thu, Sep 05, 2024 at 08:43:58AM GMT, Alex Lanzano wrote:
> This patch series add support for the monochrome Sharp Memory LCD
> panels. This series is based off of the work done by Mehdi Djait.
> 
> References:
> https://lore.kernel.org/dri-devel/71a9dbf4609dbba46026a31f60261830163a0b99.1701267411.git.mehdi.djait@bootlin.com/
> https://www.sharpsde.com/fileadmin/products/Displays/2016_SDE_App_Note_for_Memory_LCD_programming_V1.3.pdf
> 
> Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> ---
> Changes in v6:
> - Rebase off latest drm-misc-next
> - Replace pwm_apply_state with pwm_apply_might_sleep
> 
> Changes in v5:
> - Address minor style issues in sharp-memory.c
> 
> Changes in v4:
> - Remove redundant dev_err
> 
> Changes in v3:
> - Fix file path in MAINTAINERS file
> - Address review comments
> - Simplify mode selection based on match data instead of model
> 
> Changes in v2:
> - Credited Mehdi Djait in commit messages
> - Renamed sharp,sharp-memory.yaml to sharp,ls010b7dh04.yaml
> - Using strings instead of int for vcom-mode in dt-binding
> - Fixed indentation of binding example
> - Removed binding header
> - Removed extra whitespace in sharp-memory.c
> - Fixed error handling in sharp-memory.c
> - Added match data to of_device_id table to be in-sync with spi_device_id table
> - Replaced redundant function with spi_get_device_match_data
> - Sorted header files in sharp-memory.c
> ---
> 
> Alex Lanzano (2):
>   dt-bindings: display: Add Sharp Memory LCD bindings
>   drm/tiny: Add driver for Sharp Memory LCD
> 
>  .../bindings/display/sharp,ls010b7dh04.yaml   |  92 +++
>  MAINTAINERS                                   |   6 +
>  drivers/gpu/drm/tiny/Kconfig                  |  20 +
>  drivers/gpu/drm/tiny/Makefile                 |   1 +
>  drivers/gpu/drm/tiny/sharp-memory.c           | 682 ++++++++++++++++++
>  5 files changed, 801 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
>  create mode 100644 drivers/gpu/drm/tiny/sharp-memory.c
> 
> -- 
> 2.46.0
> 

