Return-Path: <linux-pwm+bounces-9037-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMkFKXScDmqZAgYAu9opvQ
	(envelope-from <linux-pwm+bounces-9037-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 07:47:32 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 228E559F35E
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 07:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 223A53054FCA
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 05:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C4C34E75C;
	Thu, 21 May 2026 05:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqiPlTMR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA17340DB0
	for <linux-pwm@vger.kernel.org>; Thu, 21 May 2026 05:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779342444; cv=pass; b=KJKvsztAfWrRKEnL3xQtrGtXgaGhAceCd2DaXGHRUNpZZvatGeObNfJNpERFiqhvJ84vjp26hq/+z7ocXsVJykn0KBprHpn/gg8xk2XEfUltx1NTH4I7PJ9FaxrRFzaL1nimv+oFLonYs/hjq9hHyW2Qu0iW/tV3RBuRQ33tpss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779342444; c=relaxed/simple;
	bh=rvRNJypYuIaXcdpikXLL+TmH4qjgE66gRUyO8Jwy6pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Whkxgj1y5B/8R8A2uIH0izPJkDIXQQXEFc38o4FEcNO389+9oiiSsj0PATouz9v+cM72FYEdrC1SgeaBg37nBLTQpipb/+CzYR55JVU9Yd1xPecKAsowGH1TsmHUmDw0kAQAH4NnqAfAyDMAgvIPcAMlXfobI4267antL4r3R6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqiPlTMR; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8b5de17382cso49168346d6.1
        for <linux-pwm@vger.kernel.org>; Wed, 20 May 2026 22:47:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779342441; cv=none;
        d=google.com; s=arc-20240605;
        b=ERMIvTTt0BiCkfhKFovaSiVimLraKmoWlGxt1tugscebJkaqv4qwvv3ffg0lo8rZWe
         +0KofxkXcoJD/zVLLvLfL3pf+vENhTLfmqlmE5PNMD6m59UHGmef9ZIZ1lbC8nIjOJqY
         edTie/2UeDEh59krGQDgWXTyMmc6YC9AgxeQHIzYeW4d0MGfXBBhiWKtjhHn6BfMogxi
         kJrVacq21qdplSuwOv7yHs8jBMZ9iS+zwtMRTkpeY9lZswrWr9VepcvPzURhrwtoyQlM
         CeeZ7hSzc1+gWTudwlpbo2plgCW97uAta1IL78mLb+Ds5+Yx/+UyYWI9hQPobzlPZz8j
         A/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w25KogIBywA1a93/rf1RBOgU5z4hh07df7N09bLqYmU=;
        fh=byCwn//VAYJTV5oiF9XLV4hqzLKHW1o3xBOXyLSU3Yw=;
        b=R7urFXArPC2ybuSB8zTy21QihZySGbLSpgHB73pV3kK6S6GhxAgUr6ng7tHHw+11I/
         YN+Y8JiwpVGU/B3JTJkTY/I+JwHGzlUS8va+fN0kc7zdI9slfRnSLAKJiTF0kFM47J+t
         xtuIo5lo2+VKcUrVkGsGmwWPbh5ZNk1fW8qUf2uqTT6kG+mclIW1iXhh5fYAcU1jQn17
         5r9NVkCgxqK77syXOey1CzXwjxTFVvpXGke61SYXG6m3lLEXtyJHl0s0VxCy64m0wU8v
         5ugacYAS0c6tgy/FRFeCYSVXkPBB4+ZSvv24w7BRYV/ovasi4Y5EIusNTpHAdA9AYwVk
         Y6MA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779342441; x=1779947241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w25KogIBywA1a93/rf1RBOgU5z4hh07df7N09bLqYmU=;
        b=EqiPlTMRrAaIc8qFky7sVocBjJblT7RqKTYG+Jfcn42rtPvYkZqxDs5uVEIexfSKrm
         yWMvp7y6UlOfKqNC00Lxw5sXNKCexJFggE8s61gcr7QxFh9lyzPxxf9gKNh1JIriHPPD
         MqxDHaLDj2lk5Jxw8IYMkZLRJ+Qhp2Lzo+zzTLRwQw6hzAMOXsaipIfLAVUStyl6PnJG
         BXjKJN13yFdT3f+tCUUMo7o2nxejTfyKIbKXkR71xOGhG6jxfh07eP8vBio5dbWG2f2x
         +e074yCCly78/lPKWGyV684uHD+X2I6DhHDhno7ds5zch59Pav+V20kddZfQRsg+YrRg
         Rf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779342441; x=1779947241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w25KogIBywA1a93/rf1RBOgU5z4hh07df7N09bLqYmU=;
        b=TfP0Qyjln0bowfnyrQqa7GEYTOi+kI9zsLen/jBfWxa4Yu3HXf7KlcvFZqtr8+EQC6
         udSx8+rdASf8+exEIKHCP9siX3jaVHtZqJXgT9E6qRn4djMvSIb3cPnBhS5Ckznu6ZWZ
         4qkDtfR76QOMTcrKiYH6sR24P4GQ0DOKLYgnf2r6YjwoxKd0waO1huRiVeypc2JBnZ10
         zcpS0ZNmoMdYf5GVtFvcTay7tncvBq6KF5tY2NssUtevnUGWhiFTQW2oZfU3Xr4bB74+
         2Rci2orgSHTOJy+RKFF/gIaGcqa1mndgMzXC3lUASdxKSV52S7Nyx4I6PiFOM1FHWies
         5vsg==
X-Forwarded-Encrypted: i=1; AFNElJ8VwlgkXHv9LKw40/mgGr5yVQw6XSwaNROOU1qJB5Rjx+iThx8Yy0iU2wUGqPQi/F2Ii848ndypuQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWJ7deDkWidUxkL0pAWf68k2lOik8ZFknnqRh2vKpBUzYLXNud
	cDBcKMa1r76EruG3nHnumLSNcvGh4TX6YL7F+ckoRvbl9lFqCaSzaCf0pMQIh+gKClTmFg+//86
	Iah17HD0/0pTxaGF6/Oy0CL8Ou+OZP2s=
X-Gm-Gg: Acq92OFk3700/JlUhukQeH4Kpv+2cG+KjZ+2jAak6yXmpAO/+KGiuw/yDzPoSkXcOaI
	EbhTvrm+rCKbXdEZESXBOVAQen2LbHx7oKu9KN8qoxI+GCKGs0iiaqcoP43rTe9r3p80FsEFqeN
	AXBVHNvDJOHYt6LYcvCuo1deMV1kmbaYQcab1SbSUaLL1WpcrVczm8REJhdT0kx9uKZt3fVXA7R
	n+cYopC/mjwYD6Dm9K7KBNOUBY6VQxRzUKN1FYTFAVDsx4RXH/UnA+o8UUMPId4upPTPxCFxCpu
	Rxlb2IViL/jH4/maVrntVJulTT5c6B2fyEH61qoXU9iIHmVIqw==
X-Received: by 2002:a05:6214:4589:b0:8ac:b1ad:3a24 with SMTP id
 6a1803df08f44-8cc6e369142mr24275146d6.27.1779342441405; Wed, 20 May 2026
 22:47:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509193928.19030-1-manishbaing2789@gmail.com> <agnY16I4sYAdRd9T@monoceros>
In-Reply-To: <agnY16I4sYAdRd9T@monoceros>
From: Manish Baing <manishbaing2789@gmail.com>
Date: Thu, 21 May 2026 11:17:10 +0530
X-Gm-Features: AVHnY4KAzV-NI5cDZgO-6QHQZfraoFlbvvmbGV2Hd6qkCVQ1Ph4LlYmyO8Rq1VQ
Message-ID: <CAJvdc_enTOF=+1rumSz4FD5T1ME0fnJ+SVC+jMuOTMxzyx8P1Q@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: mfd: st,stmpe: fix PWM schema and drop
 legacy binding
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: lee@kernel.org, linusw@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9037-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manishbaing2789@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 228E559F35E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Uwe,
> If the patch was split into two, each touching just one of the files,
> there would be no need for merge coordination. Also logically it's two
> patches. Would you mind splitting?

That makes perfect sense. I will split this into a two-patch series
(one for the MFD YAML fix and one for the PWM TXT deletion) and submit
it shortly as v4.
Thanks for the feedback!

Thanks and Regards,
Manish


On Sun, May 17, 2026 at 8:35=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@ker=
nel.org> wrote:
>
> Hello,
>
> On Sat, May 09, 2026 at 07:39:28PM +0000, Manish Baing wrote:
> > The st,stmpe-pwm binding is already covered by the MFD schema in
> > Documentation/devicetree/bindings/mfd/st,stmpe.yaml. However, the
> > PWM subnode was missing a 'required' properties block. This allowed
> > Device Tree nodes to pass validation even if the 'compatible'
> > string was omitted. This omission could lead to probe failures
> > at runtime.
> >
> > Fix the schema by adding the missing 'required' block and
> > remove the obsolete and redundant text binding file.
> >
> > Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
> > ---
> > Changes in v3:
> > - Added 'required' properties to the pwm subnode in st,stmpe.yaml
> >   to close a validation gap identified by the Sashiko.
> > - Updated commit message and description to reflect MFD subsystem chang=
es.
> >
> > Changes in v2:
> >  - Droppped the TXT file instead of converting to YAML, as the
> >    functionality is already covered by st,stmpe.yaml.
> >
> >  .../devicetree/bindings/mfd/st,stmpe.yaml      |  4 ++++
> >  .../devicetree/bindings/pwm/st,stmpe-pwm.txt   | 18 ------------------
>
> If the patch was split into two, each touching just one of the files,
> there would be no need for merge coordination. Also logically it's two
> patches. Would you mind splitting?
>
> Best regards
> Uwe

