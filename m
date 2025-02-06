Return-Path: <linux-pwm+bounces-4794-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E852A29E45
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 02:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3EC9167EC1
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 01:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4762561D;
	Thu,  6 Feb 2025 01:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TODfznbP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8403C2B9B7;
	Thu,  6 Feb 2025 01:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738804343; cv=none; b=BpL5UadZwW98YwZJd71MUg70KOFVNgs4rr2oYXBOpwZvPwxVBvYNEzewSJoCWXLuTMkzaKv79WiCj8YCu24MH95QvdaW7HVVA9FP8A5I1CpkhswjVZnx+QzioKnGKX62gGOm8soR2V19ORyyvTBbzzcePqLc0aZTIgcJQYUWqQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738804343; c=relaxed/simple;
	bh=VGMw3fH/qQ1mZr4YkUb8xkvsHfU+9HzvwMDhqK1KZpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmccbbEOISycSFvKn8AvAAy+acwEM3lUgL9X9yy3is7+yXZyOkHgkib4ZQq/heTXW5HtzgLNAr78KHj1sTzgQ8SWEJnC3e9vmYTw6dAgHEZ09Ef/OTQeuxKb63tC0t8G4EOqgjvMQJMVGs2nmL+inCanUBLSt0omYD6YjurDK6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TODfznbP; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46fa764aac2so3328471cf.1;
        Wed, 05 Feb 2025 17:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738804340; x=1739409140; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5pBMT0z7Wu2vduHIjcx/FLiyYRunJu9Lrm6JuBMMAwA=;
        b=TODfznbPb31XKfNwXUI9Y6WpAKT586HZwMfFZL+sE7H9JK0MuRCDtAIAH7LCdciMtG
         2qO7ahsgrAZBauFaZnf2vXogsKgl+QKooH3OtIRg+UAwWx0GpBlT2nXYgsfKoImWqPCp
         EzjBnUexbaGTLSVRtMWZrEQ6Kxb1qjjpCC1ouhMpEEaf6iFAIyqHUo59pMp4jObcnwzq
         fuVNoCCwQtNpu1WVqCQrtdILyreYLxVYwpfox7Fv0fc5bzGK3T0u6DItn9Vj3zxf4k+2
         rqi21KW2egYbjnoExOClqLldmgCZcJFI9tkyXJl4kmaBMqD7cwyfXB0+jHjcdW9YMTpE
         OgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738804340; x=1739409140;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pBMT0z7Wu2vduHIjcx/FLiyYRunJu9Lrm6JuBMMAwA=;
        b=svdJZvLsZvv/ykwKrlIegTomT63k30pLer9eaakPRJOXmKiJExfJY4JTFFn8t+RMWt
         jUNb54pvimuxpnWMr+OFXIDzvwG0RKanAfhWI97gYoV8YQEgbSVp3R/G+yRMnvFYgwE4
         zIBe1xyHKXU0wHWOaqFJSCPK+ZL4DHx2CPfiVSqwCQ7Yh+iZ1B2BWbm30iQkkW8kn/F6
         6juVShvzQuHNBlNhqPfqchXxokk4r0cE8zNBedBlSDKKzpwOWv1Kxx3QJN0ouODrFk5f
         gn/hGeF6Hm73y3YTGXJI1fPdvdyz6xQ07fi2XzNl+RM4ugI/VJr5WEZy8GZ2X2MFw2bC
         z0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCULldL6giiMqIi8ZAA4surNXTjWLaaBfCmGiHBRd29oRiEhu5HbHKRIENDi9rZXpIcJXEta5ZnVhXpU@vger.kernel.org, AJvYcCWw9+mQmiPZPMlsttZMJAilbOYVj7kvWS7qOs/E7Fkik0qnQAsBlUuIK6J56nJN1LT4px6CwiRTZd9nZC/6@vger.kernel.org, AJvYcCX4ArkXZDPEeVaSH+RyONvaVs7Ui/uY1/5U65Befs0mlQUsmiFD188IUHbZ62E2xwExGWc+XLEc62VP@vger.kernel.org
X-Gm-Message-State: AOJu0YxXe59iQ50BwMVYgnjCtU1bv6i/mdSmSiViHvH3hABd/9ItAUCc
	aBCRDTAwfq4SEXCWUvtvQU1wavvNS7USsM+H4CtXRXI0rFXpaUGT
X-Gm-Gg: ASbGncv5i+/4lkZXOjicDwIqWtOYI8MYXoOOLjI0IDTDnzkHJeRGPPe1ZfV6JPqQTYJ
	LsyguCXar0WHonLafsiafpBcQ7+mDwxfXKfAFl51kFVUTLgUnETb4Z5o4QdK2aHHSk7Yr/D34LM
	LjKOUM9n7EskCar8O+nwN3ooOELAo/SSa4OncMRwKktkIcqNbkNLkZ7sczdgoflMbfFyuOasF+Q
	ciUBkDAkVQ4wZdUpbajE9U9AkM1NMwVXcKQBCPNfuZV/Noy3ULfKv+ZbFod5xqRqVo=
X-Google-Smtp-Source: AGHT+IESyoVUGameDYJaCxkueA3j3WJ8VNCDRm28ssP4Wc7/H2APc3QV+nga2VASrKsUBbDJPJR4Cg==
X-Received: by 2002:a05:622a:588e:b0:467:57c8:ca31 with SMTP id d75a77b69052e-470282e9725mr69180751cf.46.1738804338791;
        Wed, 05 Feb 2025 17:12:18 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47153bec3aesm526501cf.72.2025.02.05.17.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 17:12:17 -0800 (PST)
Date: Thu, 6 Feb 2025 09:10:50 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>
Cc: Chen Wang <unicornxw@gmail.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, inochiama@outlook.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, 
	chunzhi.lin@sophgo.com, Sean Young <sean@mess.org>
Subject: Re: [PATCH v7 2/3] pwm: sophgo: add driver for Sophgo SG2042 PWM
Message-ID: <zz3uvb3qhbbqyf37s4eleqwxyuvftm277guuqkefv4kq5k2zal@kt3xjztfou2p>
References: <cover.1738737617.git.unicorn_wang@outlook.com>
 <ae8ea1bf0bb0a09336cd8b7f627a994630524bba.1738737617.git.unicorn_wang@outlook.com>
 <ivgsidvdx2ypntnlopww6fiwyuzj2sadt3znyofr54dsz3c5d4@3mr25vhwlwy3>
 <PNXPR01MB7488BA555BDE96E59741DBACFEF72@PNXPR01MB7488.INDPRD01.PROD.OUTLOOK.COM>
 <o4j72fdw6v6aiuvgeufugzptmfpmpws26zp5bf27hdq2i6cng5@yqmdasof3ynp>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <o4j72fdw6v6aiuvgeufugzptmfpmpws26zp5bf27hdq2i6cng5@yqmdasof3ynp>

On Wed, Feb 05, 2025 at 05:33:38PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Feb 05, 2025 at 08:57:20PM +0800, Chen Wang wrote:
> > On 2025/2/5 18:06, Uwe Kleine-König wrote:
> > > I was tempted to apply this patch while reading throug it until nearly
> > > the end ...
> > > 
> > > > +		reset_control_assert(rst);
> > > 
> > > This is wrong (well, or unneeded). With
> > > devm_reset_control_get_optional_shared_deasserted() the devm cleanup
> > > cares for reasserting the reset.
> > > 
> > > > +		return dev_err_probe(dev, ret, "Failed to register PWM chip\n");
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > 
> > > If you want I can apply and squash the following in:
> > > 
> > > [...]
> > > 
> > > ack?
> > 
> > Ack.
> 
> Great. Pushed to 
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-next
> 
> with the suggested fixup.
> 

Good, I will take the dts next Monday.

Regards,
Inochi

