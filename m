Return-Path: <linux-pwm+bounces-7120-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55358B2DD82
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 15:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495B13A5BF1
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 13:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76E9304BCE;
	Wed, 20 Aug 2025 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSJ4EbNb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A73C2E2294;
	Wed, 20 Aug 2025 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695745; cv=none; b=avhMr3UpyxdUibjAg1600Z/oheMNWuK0SExGqOWTsoz5OFk2nPAISLl+F14LKib9k2e5RWWQfmNrnI0o3u0ULh9/hJG1ySL3fqAJ/nwwukQFlIQ86BBXOdn8BjeUywthCQ2SSLJ0Q94RN6uHZHilJf91U5goVB7ettaT/WYhMzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695745; c=relaxed/simple;
	bh=MR95KeLBXnAjoONlEEmciqveTZvYSEB/+NGwOV3m1HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqjnxWk/nYLjkyGDaNoI/YY68gODU8D7utqq52pKN1dHdjmidzEc2FFda8HH0ZH/nOYz3NcDKGBrzFOatJvkOho+TCHRTV/TAouZuFUhdg2bGumkoRhpZ6qba7RHgzgSrm6axN0klkqZ+e8bAOigL3O38+x+U3lAVT3XfG0eM24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSJ4EbNb; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-323266cdf64so5085910a91.0;
        Wed, 20 Aug 2025 06:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755695743; x=1756300543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhA+TycHOu2hS6f7GrjCAcmbAsgcqmJx9pZ/zTGM90U=;
        b=fSJ4EbNbRxF9JfiPxCGUiw5Yug76WE4hb5GY7vCicY9JC2rJsDRBwk4Fupqg2AfjuO
         2hSNvkFUymYmd1Gu31DvUGyHvdHYzIIvslIuhQEfRO/Lfm4W0Xw2L+h80xiV9rbYY/rl
         EsNZnxcBwJPydHHJfX4KGoM5a57X/vBozkst5kLnmDWcoxf3f/QWEd6slVaB7THk0e3X
         LUuT0xlqB2ilTmAGHIC6SHMiN4DggfpfVwe6wTv5xCjruJi9te4+6Wfv07XIFxD/n1Gm
         ic2QOD7GPj1MOTZxTDKy3BSYTNKFdwtE7sKrorMmiugCkcP4N5pBlfASRygngE1NUeF/
         LGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755695743; x=1756300543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhA+TycHOu2hS6f7GrjCAcmbAsgcqmJx9pZ/zTGM90U=;
        b=cBgbfmvNKIPUTLFi68aMzyVS1PspDWf434XewrNunxL/mavbssKC77imUNzW8zx5+l
         kJlHH9WorqyDEVU58Ktb9m3frnTVIY5PdiT59B7Lcpv3XfhST90X6cA+3UaURjR1HwiJ
         sdaihbf7lB/YpZ2CHMFxPnWO2UcQlsLEhyF1nG8gYW43dVszPF0onTZDnR+U4KRfli3k
         8b6xqtqghaP37Moptg3mlOYWY/u/PFo26xqrjRS8Qv54Z7vww9ceCP43JrvGoxhIR/oF
         sakglJiLHYo1EVTJP3AF5FTwZlWe0ndYGuHob2l22fioEoiQdWLOr3GlS4KXFsXvY7rx
         Q7Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUEUi6GJtPGoBY6yZbuucsIPGO18q1bi3cR0f6CITPOzbGn8T0GMjLS1fnhDQYi86CxkvnmSI3dCsSn@vger.kernel.org, AJvYcCVvcqtIajYfSXu/uYQL5tvOJQ/qDL98hYsepRGwn6hS9ykwm1nGx2W0hacSFm188FftZedwedNW5H4OL6bR@vger.kernel.org, AJvYcCWD+7Metaagg4l/CBABPShjTr/pUuQ7yDpG687xZ9P2vorz8QuDs7ne8D9chrVCpXwx0IbVj+YonrV9pA==@vger.kernel.org, AJvYcCWG3EuAiWR0qa3R0kmhYDu1GU6rZliisUl5I59/JhJH0iRFOKE+bUolsAg4ZQnjP7SoRVz7FJCp3gyP@vger.kernel.org, AJvYcCWO02inTkf8tqn7MPPTggvB6KE8BWGeZNFewXVK9+wbNlVELXpcvky9m58oDDPrdPwCuu3LluVdZH+zS/c=@vger.kernel.org, AJvYcCWn10s8h0QiQIV6qfiUipqPXYW3jdVqcAO09Ja8qT9QRRjls1kLY5jDLOUtB9CEC9sjadv2Y3/WVVorolw=@vger.kernel.org, AJvYcCXGB+46/ZJykt/5GgVig39qT0qOybai4T8tRMrwoP/nWEETDIwtFmc7FvZvdP70MjKYdlKpyWxYyk4p@vger.kernel.org, AJvYcCXqHfMJO/inzDejhbRjwnloGIPxyrp1kBd/F1ejCjivtaviaPf8qXw/c4FfnhEU/jk9FwhcOycchmhlfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaQTOpca+hiYbaZqxP0U1jgTTXJriFqp0gC2st0TlIiPO5u7IM
	/oxMB/z4+frzdsFn4dB6sshNLZyuKM2O2zH1uPvDyekL3dtKSMqQqMq32/qcUGkQTmdsRSFRJwU
	+JkspIRUqYsyRcWzFrIB5eZIY1T0+TWTahrI=
X-Gm-Gg: ASbGncsaqmNMnKv28wH5JSMYjPqZAGJqSl4ad0E873XkJe1xz+kGBwpLYPUPoxTtx0d
	g6z2pumTmaEr2kXgsO3tFSOB7wq0VR83uQ2Q7Prr4mdC8TWYY8Y1fl/PN7oPlxw1zIGXpmljopd
	jeKqAMl2UCLGFaFFOocblBZP33z9uqqEi3mh2QlDGhMpglo97uxe5qZY22FD9xXJtL9Mh+uoMYZ
	anRR7V3C+FxSE+S/FpmcECIdtmnuzkb7TtCkFhH
X-Google-Smtp-Source: AGHT+IEQh0IA7hBcK+vbOCeiQ1tRGJH5G+7OtgvpKYYK6HmLASozA+JsGJ6hRWUdJWiR1ke/zCt0aQqhwBmm2t+61Ek=
X-Received: by 2002:a17:90b:384d:b0:320:fda8:fabe with SMTP id
 98e67ed59e1d1-324e143edbemr3404966a91.22.1755695743221; Wed, 20 Aug 2025
 06:15:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816021523.167049-1-jihed.chaibi.dev@gmail.com>
 <20250816021523.167049-2-jihed.chaibi.dev@gmail.com> <20250819-humongous-muscular-curassow-5accd5@kuoka>
 <20250819223157.0b271c74@akair> <e0bec141-6aef-475f-b997-60fdf8234b82@kernel.org>
In-Reply-To: <e0bec141-6aef-475f-b997-60fdf8234b82@kernel.org>
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Date: Wed, 20 Aug 2025 15:15:32 +0200
X-Gm-Features: Ac12FXwJjTEuvAdX2Wnbu9Wcm5-vo-L0VsLLi4HcMA86Hx-OXfvGEyfpUyCJh3Y
Message-ID: <CANBuOYrs2QNRXd6Qc28tBDSySrbh+vJ83+-+2XxB3jY2fH9qtg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: mfd: twl: Add missing sub-nodes for
 TWL4030 & TWL603x
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>, linux-kernel@vger.kernel.org, 
	peter.ujfalusi@gmail.com, dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, lgirdwood@gmail.com, tiwai@suse.com, conor+dt@kernel.org, 
	lee@kernel.org, ukleinek@kernel.org, broonie@kernel.org, 
	gregkh@linuxfoundation.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	aaro.koskinen@iki.fi, khilman@baylibre.com, rogerq@kernel.org, 
	tony@atomide.com, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-omap@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 7:57=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 19/08/2025 22:31, Andreas Kemnade wrote:
> >>
> >>> +          type: object
> >>> +          $ref: /schemas/usb/ti,twlxxxx-usb.yaml#
> >>
> >> Are you sure your patchset is bsiectable? Apply this patch and test. Y=
ou
> >> will see errors and you must fix these. Even after fixing you have
> >> strict dependencies so your cover letter must explain these (or mergin=
g
> >> constraints)...
> >>
> > what are the rules here regarding bisectability? non-existing files
>
> dt_binding_check.
>
>
> Best regards,
> Krzysztof

Hello Krzysztof and Andreas,

Thanks again for your feedback,

You were right that my series had strict dependencies. Testing again I
found that a
local 'dt_binding_check' -only including this patch- passed, but the
dependencies
(non-existent yaml files in $ref) caused errors during a full 'dtbs_check'.

I managed to fix those dtbs_check warnings/errors thanks to
'additionalProperties: true'
to break the hard dependencies on the other new YAML files, and by
adding optional
definitions for the 'clocks' and 'clock-names' properties, which I
found are used by several
OMAP dts files.

Please let me know what you think of this, and whether I should send the ne=
w,
corrected v4 of this MFD (single) patch.

I have already sent the independent v4 patches for the other
subsystems (ASoC, USB, etc.).
in order to reach a much better orthogonality and independence between
the patches.

Thanks again for your guidance.
Best regards,

Jihed

