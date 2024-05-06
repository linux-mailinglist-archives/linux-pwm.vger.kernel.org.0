Return-Path: <linux-pwm+bounces-2159-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD13E8BCF77
	for <lists+linux-pwm@lfdr.de>; Mon,  6 May 2024 15:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5441F2192A
	for <lists+linux-pwm@lfdr.de>; Mon,  6 May 2024 13:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45DC7FBC3;
	Mon,  6 May 2024 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1QhkbCi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F338E7FBBA;
	Mon,  6 May 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715003379; cv=none; b=E2RytTaEarcHL+KxYE3RkZTU6JVAnIFD0AeCNItG1zSrUdnSk2plgXaLsMFer6/iHTX3gy//5FBXkgwYDthx0PhoRH41zNY6l2igJJuwOu7rUP3ZJvfW8srzNAi2Ly9oIcE9c7dyTSl1oDWiG7NCTMe+6hvSmt4CB24KG4uAdOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715003379; c=relaxed/simple;
	bh=VeYTlSC5e0onakW3rKrio1y3PTvEXFB4w3FqeXv54R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFouI721ubmmpedz01E0x1SjdMw/dRl864KO6FSUk+y6HgjNU+3wKYORoQauJitgCdKmq00b+PrtLSGAZ70Vu6VpuwbtnwLOjgw5yrXkFNWd599ZK5okR/N+MY7qPSflIIwBSrhNydDozeMuGD1HqVQi4eENqEsE5PGYK0lQSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1QhkbCi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so18820455ad.1;
        Mon, 06 May 2024 06:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715003377; x=1715608177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0tf2qu9Q8Di2qMp5UR/PKhNSbAhcOms4Eni4j4Wu/o=;
        b=R1QhkbCi0fc3Xjz8OP1ckLFlW/5xarey+CHz41prrImsxYQOuKcX8dlbM0RMhXJEaV
         pdrn8O1+ue732K/HAWqd0z00pjxwSUOVKG0OzZgJgaFCLRXI+G5ybPU3I5LN/MpeEkut
         W+qXokBrVHrmTHCSKmFUbZka8nFkduyL8xHg0+9S4+1W6PQKJJpMDmy/q/GZqjbbddY0
         8S7ba1c8QAyTu0V5+dA76PR3UxzitwkgublPHgAPrW2i8Q1S6JAGXJWZ6rUyBDj5AHbq
         PoYQFsnzsUSIZF3ChnGdPsEGgsQvQIt6+lG8Yv01aZprJiqaL9gSWRDPoVBtMejytM8G
         zAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715003377; x=1715608177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0tf2qu9Q8Di2qMp5UR/PKhNSbAhcOms4Eni4j4Wu/o=;
        b=j5Fi98VmcdOqWd+9qqYcN9TFILuzADoy+J7KlURD21bTl/8wh/g7qSIykN4Ongq5YW
         mtVirn+PT3fel2y4Bm0JPg60td9bC+Z/PGZyLmri7gYDecDjjcKiOVGqqbhVHu9hKtln
         hjkFg+qk8/78+z428eZTQVxWxDHCfaUN8uuzqe4oSVupCl8fn2ibsYCDkHGBsIswjhIV
         +CMHQ8f31Gg/hlsXuGo6o8dfaeR5lB5c44leHu1w7g6wOffdVFb+UHzuRZiqN/UsN7rc
         H6oCYnDjNsxEHcFlMgsgoExnGLdiHzD+r4GiIidO6mNF70UJTdd51I6t72C4/+oNLLA+
         BWtg==
X-Forwarded-Encrypted: i=1; AJvYcCV7JcixGPi31J9JQ9v1A96KCn4SFx5j0fPXwfXALX8fmd5Akj3pER8+i7HJq+17AJzCJQeVKz0EK06/UIDbM8K8Nvn8cEks8n1Q0c2nkR1EIywdBRR03eQm+m/ASoR5cG3TjblYlAnlpSKstwR10Uy/o616SqfrsTPhu/G5gPuV7pFqQak=
X-Gm-Message-State: AOJu0Yw1LgbxfUsZCA6LOtMB8mWuiok85Worr75N1IfT/G4dLPFESNfa
	BOoYb1STKhTVC2jIUnVICIsCQqUki5eyNai8y2UQvi/9fwqU5/kd
X-Google-Smtp-Source: AGHT+IFsSZGL2it7t9nrfAcHqKBBtNdyFp8UV64K//be7jHkwT4m1n655IsAPNPg10zU+pm1Y4qQLQ==
X-Received: by 2002:a17:902:e947:b0:1e2:8841:8d67 with SMTP id b7-20020a170902e94700b001e288418d67mr14383470pll.32.1715003376608;
        Mon, 06 May 2024 06:49:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902d3cd00b001ec460b50casm8290294plb.307.2024.05.06.06.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 06:49:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 6 May 2024 06:49:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Rob Herring <robh@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
	u.kleine-koenig@pengutronix.de, Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/4] hwmon: (max6639) : Utilise pwm subsystem
Message-ID: <6d424919-70cc-43dc-a5a0-eab24f42f9e8@roeck-us.net>
References: <20240416171720.2875916-1-naresh.solanki@9elements.com>
 <20240416171720.2875916-2-naresh.solanki@9elements.com>
 <ecddd7f3-fc25-4021-9758-b00893ac9622@roeck-us.net>
 <CABqG17hebvkpvxwGVfp0nT_YMrvgdkEqU2_XjijCpdtgU6C+1A@mail.gmail.com>
 <1294114a-4509-4c8a-a0a2-39f6e5f83227@roeck-us.net>
 <CABqG17hamhz9+bZ44FNkoSU5MxHLB13OZWGgzhr6xdDjdb=2xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqG17hamhz9+bZ44FNkoSU5MxHLB13OZWGgzhr6xdDjdb=2xg@mail.gmail.com>

On Mon, May 06, 2024 at 03:35:40PM +0530, Naresh Solanki wrote:
> +Rob Herring
> 
> Hi Guenter,
> 
> 
> On Mon, 22 Apr 2024 at 18:07, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 4/22/24 03:39, Naresh Solanki wrote:
> > > Hi Guenter,
> > >
> > > On Wed, 17 Apr 2024 at 02:52, Guenter Roeck <linux@roeck-us.net> wrote:
> > >>
> > >> On Tue, Apr 16, 2024 at 10:47:15PM +0530, Naresh Solanki wrote:
> > >>> Utilise pwm subsystem for fan pwm handling
> > >>>
> > >>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > >>
> > >> That adds a lot of complexity to the driver. I am missing the benefits.
> > >> You are supposed to explain why you are making changes, not just that
> > >> you are making them.
> > >>
> > >> Why are you making those changes ?
> > > Sure.
> > > This is to align with fan-common.yml wherein chip pwm is exposed.
> > > I'll update commit message
> > >
> >
> > Adding lots of complexity to a driver just to have it match a yaml file ?
> > I'll want to see a use case. Explain why you need the pwm exposed.
> > "because the yaml file demands it" is not a use case.
> The idea behind this was that this approach provides flexibility with
> hardware routing i.e., PWM0 might be connected to Fan1 & vise
> versa instead of assuming 1:1 mapping.
> 

The chip does not support such a configuration. Any hardware implementing
this would make automatic fan control using the chip's capabilities
impossible. Also, userspace fan control does not rely on the pwm subsystem.

This would make sense if someone was to use the chip as generic pwm
controller, which would be very unlikely. A "might be" is not sufficient
to warrant such an invasive and (in terms of code size) expensive change.

Thanks,
Guenter

