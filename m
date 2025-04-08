Return-Path: <linux-pwm+bounces-5371-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CFCA7F55B
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 08:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F973A9E62
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 06:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C1625F99C;
	Tue,  8 Apr 2025 06:59:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6EB2063FA;
	Tue,  8 Apr 2025 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744095571; cv=none; b=nKf07Ai2X/Ui5WvN1lLL3gsIGi7bg0HPZzFrj+K3+JkAc9RRzNEQ6vI35nnxZZwWQjrzmvM1X8NqncdZNbNylGiBpCF+T90HTsWrYZSa0CsxCA7/O6pmoTs3K4sWuDdi2SoJoVZGgXYheO29vO+EN/gjeR8Qxm8pbcwFvuf6SPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744095571; c=relaxed/simple;
	bh=snAIEc5ZyPbwD4Eh9FlhXy8CECaIUO9YWMJeXNjXXKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLTSW3j2nnw0EpaE8SoyuxTFGD3zJcl06w3/zLQTjPcePZ8pPbgjjo1euAM12x7qiLnPXLv76WzYi1b/+VHZBY8TFbA/7Y0bijlsnnsYbGn/aYWJDs9hIrJvyONYfZwSZikptwrP5GiSV4G3c72JuylbDkrcuVDee8diKCTTXcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86b9d1f7249so4472878241.2;
        Mon, 07 Apr 2025 23:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744095567; x=1744700367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENS8/lcG5HmpDuN4HU90AXuzWeROSJ9Y1N1msrf0CYQ=;
        b=OTc3UXrgilFWGla2jNTbsFwE3CO1ccZarDgTcFlw4G2njFsTW2w/DlFhljZ8wYzJiA
         AWXeYC7SpqaJPOCNk8c49SPl8NbY2O8c/oC2BaRM7sYXdt72b6MzKL041MfSt5IeBmPB
         CpN2V+DYIlF9HAu31V2125oIhlYQ0tE/juL4yMLTUl0Cr5KnuHAywWYsXyHk4jN1OFpA
         yJoz2nR+4KpJ9T5ZRycDsdONdJxKRg/91zfKhxdg8VcBVqqiQiLLuPPo8sY1lYUiU3AL
         jqmFIYZFTE/YC8wrALBEfk97dPogTQWH/YTUBaG35K+wXkmR+Qz1FOb60GDXH3KijwO6
         VPgw==
X-Forwarded-Encrypted: i=1; AJvYcCV74OfcfIwz8w3dHrDD2PQahyU8/tRyTthSEyJWLAr8ys44ey29u+siftgoxj8jZa/sZ0PcUFy6MhlplPEgKJh+u1Q=@vger.kernel.org, AJvYcCWifO6kNldG+2mMGswha2Z47a+TqpewLwZKD5gng+fE7zKkX4GOWKXpuD7LMYVBtc7GBhSmyZMlkzUQ@vger.kernel.org, AJvYcCWuKpdTXZx2QWl0VwcBHeaGCDZ1zUamZHcgLLqZLYY5TgVjq8hiEtrc+0CkrQKYxKU5ihNWBhP2/wHI@vger.kernel.org
X-Gm-Message-State: AOJu0YwOhvFSEzcYj5n4Vd/1hmTq4WohrmmDrAWa1lINiM/iDtYj9K8P
	BQEkPZxzqgMeo+ZBj9DQkt6e3ayHdbRM26vzekkwtGUgjIsnRuD3/HSASXSr
X-Gm-Gg: ASbGncsd6hbQxBYQ08MF94rZPNSNwfgRI37v0c0MX5Ss0/nru2462qWgch4bOFLb7Ry
	X9U34fhcCUxPDPWBH/BEBYNgjl6csiozMpTN1f9AaJ4j1UY93MZzJNk3B3IuSVmWESH1iEcIGXw
	pZ7NBaGVMAumoR/vR6noUGMX20jb0T6BgbP+kzE6nYDSkO+cRbGQUiIc9bYLGSR0Wkbd46jT/af
	HlVbevtYICFils5CzqpLbZS4Is/4lIezkmdJT7AYFCo2rYzGnCiqx4i09qR49aND12kq00RT9bH
	AuJ60xn0sjNkTlDns7K4MklNx0U9Sk2MrDG4/+Bxvba+/dZZyafs1vIsmf2OJ2q9o/DkCFMIRoX
	9Ro/McvVGJH0rQWVaKQ==
X-Google-Smtp-Source: AGHT+IFl1iqzu6WMe7GDZDGfjywVcwT9miqF0ELppeYKBX9Mp7hNKkbYkvwrt9/zMz2IHTpWIqkv3w==
X-Received: by 2002:a05:6102:3f0d:b0:4bb:623:e1f7 with SMTP id ada2fe7eead31-4c863779c2bmr7955210137.16.1744095567501;
        Mon, 07 Apr 2025 23:59:27 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c9b4482147sm252530137.13.2025.04.07.23.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 23:59:27 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-86d2fba8647so4836346241.0;
        Mon, 07 Apr 2025 23:59:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQppzws8SejBJUb5k8qs45Dn1Q747tuLL1r9ZbOvbHkgI2DgokiIy1W/IuLqGTILo4xzU3HYDCz2S9@vger.kernel.org, AJvYcCWsIGQucZLYD+qxOZ91s6iBFBhAI1ALdabsUAgg/GW11ocuEygB+UuJTpvDv2xcd9LferOHHy0/qMVUoBGWQ/lr1bM=@vger.kernel.org, AJvYcCXNUvGg+VmmVE9KA7noqNNm88/2YyRgLDeEeXIMKIAiULC68WM6BPRpIfYtxFxERvR3E512rm6F6P/R@vger.kernel.org
X-Received: by 2002:a05:6102:3e8a:b0:4c3:64bc:7d00 with SMTP id
 ada2fe7eead31-4c8637ae1dbmr9131704137.24.1744095566739; Mon, 07 Apr 2025
 23:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <877c3vnq0k.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877c3vnq0k.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Apr 2025 08:59:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXXwJq+6tS+dsUFp_Py6i=zh7z39tUxMEJNXkG9=pRCmw@mail.gmail.com>
X-Gm-Features: ATxdqUGWk5Heoq0AsfLpFY-aqpEf7IKP9PKQhPBCKi6qDe8wRUDowBnb1w3XPvc
Message-ID: <CAMuHMdXXwJq+6tS+dsUFp_Py6i=zh7z39tUxMEJNXkG9=pRCmw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: renesas,tpu: remove DoC
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Rob Herring <robh@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Apr 2025 at 08:09, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> commit 1c4b5ecb7ea1 ("remove the h8300 architecture") removes Renesas TPU
> timer driver. Let's remove its Doc.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

