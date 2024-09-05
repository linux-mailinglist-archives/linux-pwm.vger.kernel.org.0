Return-Path: <linux-pwm+bounces-3113-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B5E96E412
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 22:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428B21C212CA
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 20:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E22617BEB0;
	Thu,  5 Sep 2024 20:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoKIsS1F"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9953CD515;
	Thu,  5 Sep 2024 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725568074; cv=none; b=RD8yiEaxorkf9fdHGwHc3joVTa+HdDg/L0Nbm/oZ4kE0c+/2CQF5gzqWrhSyu4+thuwFwZC1fjhCtvTvCpPOQ2whnKdobagnbwaJyi/MoSOoJLtvDb8IYnk8K5UTKzHjvMIU7WFTfoBdbJugdy3j5CXZjKlGQRvrVJXG9dIlh80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725568074; c=relaxed/simple;
	bh=wg3v/Bzl6fHbsDe6vUK0VkO4iWopD9ovPVhR1LwUhPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kF0IIm7IN6l9s8qwWVkm2IyIyH9qDuwzyhOEsiG2jlZBAoK39vGI7ZzhdBZk0tpuEvqdKtH9TfdzJwERM8nkYPL3wN/4YMshNuHkPY5pKbxnbb0hmR13ktw5Fm0XfJMLl4IWenmjL5SFxjD6fOw/w352//xdv8H2KUc38tNt7+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoKIsS1F; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a9782651bdso200435785a.1;
        Thu, 05 Sep 2024 13:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725568071; x=1726172871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ID4h32vMpKJpRELS7Wjz6ZK11jdarXsZHBRZ7AsCm8=;
        b=EoKIsS1FtNZ6D8HrFwabO/ZEs0jC+8RjHXQsJmZ2z3Q70XQ8K8HcZgWEQDAuN+vFq5
         KJyI37Y0fU8RcQCLk0u0NljhLFpZftNCAaaPCk25ficqvXpmszVFy0gW/uyxR6nliw72
         68zCUuG+xzUU6HWqK4ZztNO6x26ThLMi8S4eeht+903msIjaeZASAZBnazM+R6RdfX9f
         FZzIcFMSyLPNgsvCtDUaxb1gRqOkbvfb7kbFQPZ1R5jBeUWH4tp1t+dmW14+UhWsc2iW
         LBqLHV3GMnLAn+G02nvikKGMg+3xpt127xhEyJmH4Jj0eIN8C+6dB41TzJhOv6upptpw
         kwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725568071; x=1726172871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ID4h32vMpKJpRELS7Wjz6ZK11jdarXsZHBRZ7AsCm8=;
        b=kxcAiyC6Ae3VDUmVDUoktLA7VeUtI7K0yjztSGyRogt9RGSgaykNN9O228mP3eduJW
         k2hx6HHfFMIc4xF6rgDwx/WKh3J31FTNaVOEy75Wi/cJRjE04yHOqEEPrY2oKmkGte6f
         8WeCNR1Fqg/PpCTO3JyllKzHWNuWUz9Jvv066OgOqVlI9DCIrZs6R8tmAgKJSF23cZ7+
         brTtdXK8ugySZUAziS5l/tPQuwQbg8I3tnyWmSTUgAbFUG8mo/yuWYBiLcKjTi91FDfp
         GN7fZc5NiIbeYTRwaDxbiIjQtCMakiPgHOGmyHwwwSSLVSRnKyF4+lCptKz5eNu1gM09
         Yg5A==
X-Forwarded-Encrypted: i=1; AJvYcCVm1YU8Bf4mjGSKyQW6APGM44FYqtpBS1QxTFe9QwzxmuAGWM6L/DycOWk+Ty5xIZEopFY3ycdudV+U@vger.kernel.org, AJvYcCVsb5oJ457OI1wiaWPXCQ4jaxgV+h/RvThiSt6C8+PqS+eKVFNnsCj5cPCSYOupzJjEjT6UucY5lm3HxqCs@vger.kernel.org, AJvYcCXEUFZdFaegkz3DDw6nA21aWlx8XkhP1g6X6wsTb7jb6d/F9bZOkW27lbgLk22ze5z5hvX2umIgxMTT@vger.kernel.org
X-Gm-Message-State: AOJu0YzVvgnSH2HsIr4ItW9K+Yh4oRSfocmp4yD1avIoINvTXb6xWFbz
	edlAakdWhWfaiOVCc3zj4H2xDIPwOrwb/j70o94d6z/DHzRravRn
X-Google-Smtp-Source: AGHT+IGbZB34qSMVQXaWXVGoFS+5k+r/7KenyVF92+5VxThGj7KDYCLvSxV5ux3DDhJjZvlE7MIaPA==
X-Received: by 2002:a05:6214:dcf:b0:6b5:2062:dd5c with SMTP id 6a1803df08f44-6c518def647mr137814096d6.8.1725568071408;
        Thu, 05 Sep 2024 13:27:51 -0700 (PDT)
Received: from VM-Arch (239.sub-174-193-4.myvzw.com. [174.193.4.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5201dee67sm10610496d6.26.2024.09.05.13.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 13:27:50 -0700 (PDT)
Date: Thu, 5 Sep 2024 16:27:42 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Mehdi Djait <mehdi.djait@bootlin.com>, 
	christophe.jaillet@wanadoo.fr, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: display: Add Sharp Memory LCD
 bindings
Message-ID: <trlyhlclf74itbgj4x6baj6ga6yipdicw3c6odtjgxtbw3cjyl@lyfiny2yiz35>
References: <20240905124432.834831-1-lanzano.alex@gmail.com>
 <20240905124432.834831-2-lanzano.alex@gmail.com>
 <a4520c05-d64b-4ef0-823c-6c568b459e21@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4520c05-d64b-4ef0-823c-6c568b459e21@kernel.org>

On Thu, Sep 05, 2024 at 03:23:20PM GMT, Krzysztof Kozlowski wrote:
> On 05/09/2024 14:43, Alex Lanzano wrote:
> > Add device tree bindings for the monochrome Sharp Memory LCD
> > 
> > Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> 
> I don't understand what happened here. Your process of handling patches
> is odd. Tags do not disappear, you had to remove them, right? So where
> is the explanation for this?

Whoops! My apologies for wasting time. Nothing changed in this patch
I forgot to add in your reviewed-by tag.

