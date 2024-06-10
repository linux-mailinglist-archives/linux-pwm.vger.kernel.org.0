Return-Path: <linux-pwm+bounces-2390-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BEB901B13
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 08:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2B42846A1
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 06:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9246315EA6;
	Mon, 10 Jun 2024 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maD5NkFL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9F117556;
	Mon, 10 Jun 2024 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718000475; cv=none; b=pQmW/SeFD0rAPz0RVUM4EyQjPnxOpMUBiJjSKU4yXgCCIXjFPTi0TZsXsSz+JZe1+oBiXEfQoUcXfQeq7HlPNSrQsZz1VfNW3OqRofGOuPVjOxg/AyQNl76ohcGe9yWqfIFEp/zpQYKgMRAOrTLahG1S0HCJ/fbJge8GQCRTztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718000475; c=relaxed/simple;
	bh=htMYL62EBgOyd3NO98KvEswQedQdv3hijD5lAZErPDo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=L1wOuq4BYxJRDle2gqKs4EvkKW1Rhgjh/Sa2Mq4fed4yOsnBmGV4jKCerjcUNBHLp1ZND9Ep77WHYm7WI5PDOSxqnDBXiHe5yiPe/sIfymUSlKRTHV2rIHlddXmYG/lESsB+jnncKk/X29J3dCEEAwDACIXfngRWS06N2dWiT/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maD5NkFL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f21ff4e6dso29384366b.3;
        Sun, 09 Jun 2024 23:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718000472; x=1718605272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qswQsB6GG8jzu3P/wsKzIrL88cPkFRyaSp1SLy9L8Mg=;
        b=maD5NkFLfZrBb7/OzLIZXmcXUF1IDNvRVZg4wMMpXKtL+36dGruk61Rki8WIWB/6bv
         L0/bSxCnXRnTfzOa/jKtJebo6XLtH4sfTxxJwTPuTOeBVtBOqYLrejYQmABAErL8uGS0
         zQgkfD4aWiYO1m6SILrvLfCX+dEG2cpA45PaLFijd1tFXiifagMo03/K6bD6unoJiA9Y
         oSflNH0BGOx/wvLPQgn9iQFacCC/G9Zm3O09AebRegQQw+w14SRgbDHlrSYjIG3T8nAW
         LNJxNc5Uzy18HLV2R/DpmE9LYnZlkzIBXxFmsMyaFs7pEl3TBlrh9nleuXxbiMS++8Ux
         Mp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718000472; x=1718605272;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qswQsB6GG8jzu3P/wsKzIrL88cPkFRyaSp1SLy9L8Mg=;
        b=fGeL40Sx/FAVvfWSY1FG7Hh1HtzbhsJsYqdmKb+BA3OeHkwGvo5nJeAgUATYyaB5gw
         +nHMqC9LGXBF+/Jc9G6No+SlFn7BMP+joH9PlQCnHPfuMyAVwF4/VDhPZDpBsv7wMape
         fC21Ixpw3iuA8nznu9n/eqSs2RIrOHnPJMmcDeTgNQSvn9LoNtHN8D+a91dyNfqWcTYK
         cFAtbXT0wpULw4izlb0NnkYX6flncr8TMxRLCbYuPetduhKXxlp9mN1IVrXwP2klZfyq
         XJI5MpYoK/8rYAHVmLJUcluo8ILU0B2rZLlGm82Q0RjgJrXmw+Mez8rXQT2IgHRkPj87
         gwtA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/Pb1Wu34Biu/fbituRiJlselWwKFm4dZcGzgocrm964kNMK8EmutXYw1m84AUwOJaS8dzH9X6xPdUVn5YdmwWSrqbSDaXrABUMY5dyg1evn5kH+B9yKRlYivlRHZjAvI8VjUvY2U6vo5rZBQQErUph2ivZn89XEyU3iq7MB/fpVwn8wwZNNeiBSz4zG3BxixaXvpT8GEI8XqtFcyISM=
X-Gm-Message-State: AOJu0YwYdLJ+Z2dMha6zdiTljbMiuc+7n57F7yumvecssZ/7+Ahb8oIi
	NgTqVeMeuZFg50dMMzDkccTX/zvVXOEYtdS/b2Z9G5wXuC4NK7d3
X-Google-Smtp-Source: AGHT+IFqLPALWZIZIbUadkqAjMgHaOSVsBi7G9vJUL51aSZdsu42FcyFDDDbBNSEzUxFl7u7eCdaIg==
X-Received: by 2002:a17:906:46da:b0:a6f:2dd9:1449 with SMTP id a640c23a62f3a-a6f2dd91a59mr849466b.49.1718000472082;
        Sun, 09 Jun 2024 23:21:12 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805cc38csm600798666b.71.2024.06.09.23.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 23:21:11 -0700 (PDT)
Date: Mon, 10 Jun 2024 08:21:09 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: laurent.pinchart@ideasonboard.com
Cc: brgl@bgdev.pl, conor+dt@kernel.org, devicetree@vger.kernel.org,
	krzk+dt@kernel.org, lee@kernel.org, linus.walleij@linaro.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, robh@kernel.org, ukleinek@kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Add Analog Devices ADP5585
Message-ID: <ZmabVXaztPbp1ENV@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240608141633.2562-2-laurent.pinchart@ideasonboard.com>

Hi Laurent,

> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 0a419453d183..91e62df4b296 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -39,10 +39,6 @@ properties:
>              # AD5110 - Nonvolatile Digital Potentiometer
>            - adi,ad5110
>              # Analog Devices ADP5585 Keypad Decoder and I/O Expansion
> -          - adi,adp5585
> -            # Analog Devices ADP5585 Keypad Decoder and I/O Expansion with support for Row5
> -          - adi,adp5585-02
> -            # Analog Devices ADP5589 Keypad Decoder and I/O Expansion
>            - adi,adp5589
>              # Analog Devices LT7182S Dual Channel 6A, 20V PolyPhase Step-Down Silent Switcher
>            - adi,lt7182s

seems like you removed the wrong comment here? With this, ADP5589 would have
a comment describing ADP5585.

Regards,
Stanislav

