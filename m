Return-Path: <linux-pwm+bounces-7423-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CC3BCA2CD
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Oct 2025 18:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478951887370
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Oct 2025 16:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC7B22128A;
	Thu,  9 Oct 2025 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCnG8vPR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4412B1E51EE
	for <linux-pwm@vger.kernel.org>; Thu,  9 Oct 2025 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760027037; cv=none; b=FxuwjMfC6+RTfAD6DazyjTYIw+59QIuzCY6zsx8iCxtunuL5Jpc0rykygRkh/VvwbyjfEkXmdarcNWUu6EqdeO+7ZApQF4dzqJ8m00tKK61X1oKBQrPDaEoRG5x46etxNFVx50baYn/m96/lFvTOn0ZO8GsNqK+wRUruT9VmSCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760027037; c=relaxed/simple;
	bh=eVvkeQWqrG4dYBffY48He8ILJTh8EX7LtPQhkX3h+lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHe0MlsSR17Loba+TVyZ+TlBOmhKiVkwSDImbBCY3cFucYBWI3BRs3zEvA+rzKrBw4aR5HITUzaKw/+fRBk+nTyiePsdAPucMI0bhW4VLwTJgVpKjbcX4NPO3NjKodrSiV6Qst09yGiGR4uYirPy8ceDgWjJzjNeoKqF/paKZl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCnG8vPR; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so1662971a12.1
        for <linux-pwm@vger.kernel.org>; Thu, 09 Oct 2025 09:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760027035; x=1760631835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j4C1j3OOKsjCqjPjMDTFb2+CfJ4gki9Qbk/4PqhkQDc=;
        b=MCnG8vPRQYAB/sRTi4esoaO/JWYoy5ApLLqeX6QndxwVYySMVYJKfC4gJjO3FwPqSV
         S30/FC8jXscm2L1XPxnjUqDd27oc5xOjcOGAGIa/5BlueteWIktVI8o/v3dMZDbmDeF8
         z5AR8SUuVLUDndif6y1kd0i2+o7Wee/2h2SVC/9uVSGcm5WK5k7oueRP+T90pEh+XE4a
         1d/kTqHfwlX9LPsj0YGzfnpL06PNlMtzs7tRQTGQIyBbwtT+lH5U1pKcVbVIix5OkX9B
         3adjH2abP2vWlPTF0J3nPlLFMQsmVhism3zMR9wh1pzs/U7nQ3hoL6WTMqh4mJNEytzO
         UfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760027035; x=1760631835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4C1j3OOKsjCqjPjMDTFb2+CfJ4gki9Qbk/4PqhkQDc=;
        b=J9z6AY5BqUB931CK4quTAkK33xsutztPfHNsN7p7qLEbwsZKCZHTh1kkgyKRuk5RpP
         AF192JCihLYRL/ta8cgjt1bnu10yLj9tUwtjfnpleOKUf/4w1TYgnRCgRBvIb2ITmuW1
         Xzi+4extPU7MM+mtQ7iXn997BYJ6yKOrSWXoIB13wn9x+708XHJZlDMc0ZsRtjVD0ejQ
         7q86wWy8p0QFbnqnN2fNzHJ17/DVieYRnQ1IDQLp2SdX3uwdAHeYZmqdejGni+rdXUJJ
         cC4MaBQexP+fNNxhQaJSGieAQPewPNf5+kOdqQBrG/Ki0ovLxzasijg7MphZ4UF+qgLo
         QFEA==
X-Forwarded-Encrypted: i=1; AJvYcCUECNCrB83twK3jmzSAD7G5a09+mkg9RjuhukoZzJbqxTstZstkJpxhWVM8QMDE1SxoKAtJMAwjcuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+BgCMptYeHwioqx+WFRnPOaV0rRCuN4HuxcZYQjIZt5XILMvl
	ebQ2XQkGWIT1opnuy6LN1JfBln27co4KQUDTfXnhL0lbywXxqzktoorg
X-Gm-Gg: ASbGncui1A4xq+dFB0LloN2HQAdG1tkYZ4MnamaF9mQWEvMVu8o0siPz0SAFqJd5PfP
	Q1jLUT+JF2jrMEEUZJtQAsAM1nUpQLd2vXqcpznVrrjGN4Wa38k1OxuHkkAeQonnLfXbNUXH5v+
	DLz2PZan3r18OA4822cCD5v4K8JH9Iw2kEH0cgn5dfShMPz9GChiCTtG3cr6W/+7mP8N92f221b
	2RcMYko1Hvsoct2/CBlcwXgJFm2D2H+CdaWytYzK8kqR0c4jBEolHSytT/d2Nh6gjdZhUEVVvzn
	djmZjN4WHIapUXsk0vxyEhPwgMedj8g/rVIte1vthSkr9k2lQgXv1OgJbh7McT77wuBhOhI3Alo
	Pr+3cxM+WLLjbsI+Rzg/rVY3l1aA58gFe4dSauxIFdmLLju8PYCu0+y8=
X-Google-Smtp-Source: AGHT+IG5iTuS4lml5ybOjWvkOCPTHDj9ZrBTt/dnU/W0P0sGl3oiFllm8k9GBt9WpwjupCqN6+ivSQ==
X-Received: by 2002:a17:903:1a10:b0:271:d1ab:17ce with SMTP id d9443c01a7336-28ec9cd59afmr138719345ad.26.1760027035566;
        Thu, 09 Oct 2025 09:23:55 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29034e1854asm33475565ad.37.2025.10.09.09.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:23:54 -0700 (PDT)
Date: Thu, 9 Oct 2025 13:24:54 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, ukleinek@kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH v4 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <aOfh1puxPJr367n7@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
 <7e51e036ba930284c74cf42afd53b17d49093654.1759929814.git.marcelo.schmitt@analog.com>
 <20251008-penniless-tiling-9a83d4b4ba48@spud>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008-penniless-tiling-9a83d4b4ba48@spud>

On 10/08, Conor Dooley wrote:
> On Wed, Oct 08, 2025 at 10:51:37AM -0300, Marcelo Schmitt wrote:
> 
> > Change log v3 -> v4
> > - Now only documenting GPIO setup to control ADAQ PGA pins.
> 
> > +    else:
> > +      properties:
> > +        adi,pga-value: false
> 
> I assume this is an oversight?

Oops. Sure, should have dropped that.
If the device is not an ADAQ (no PGA circuitry present), then we should not have
properties associated to that.

+    else:
+      properties:
+        pga-gpios: false
+

Thanks,
Marcelo

