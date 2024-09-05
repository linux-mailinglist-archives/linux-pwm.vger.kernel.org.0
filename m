Return-Path: <linux-pwm+bounces-3116-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9AC96E5C1
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 00:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51081C238BB
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 22:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5036718CBF6;
	Thu,  5 Sep 2024 22:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHSo3hdV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFD113D638;
	Thu,  5 Sep 2024 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725575502; cv=none; b=ez0tORwow61hIsu4wWd3uSPOBEtKR589Hu6Xhk0L0ASXMKiEtLLj7gosNuLgTocCTTfMAS4wc4MUJfIs9TBpn8R8wqCy84jhRonQRlupvxu4g1pF4zTCZnj+M6NqNGfzL63FHIg6ve/2NFb+fYqtHSVDQgLqwvOeYMF66lcZtSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725575502; c=relaxed/simple;
	bh=ImZuOxNJ7EmSvzdj7PGLyzPv1nqU1DZZ2z7TkryXsMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNuwn73pKyu81mo7I0WzhAHzQILgBgnBDqgT7sfH0gdcn5h+1PEWYdzl+wCO3qN9HrfFuFFlu+2e+4wBhb2ldApEMJMPa2YiGWuwJNkcgszGix0ADSW/DhC++PiAndQkVLnvENFeobAj1xwGpaC4GjgxUqHXq/ayTl/ol9Pq9bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHSo3hdV; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-26fda13f898so863948fac.1;
        Thu, 05 Sep 2024 15:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725575498; x=1726180298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ByTGY4/YW1oFlLnwGbDA1qTS9L9gMEUay1+a7RZYMwo=;
        b=LHSo3hdVfBxT6eHUF+HUyKIYtlKAJ3uugys6HH9h1WlKUqj+VN7wOs2IQnCrm0XSEk
         9wWx7OyorOAHLOc4C2tPw/vCVLebgtVze5Rj14qz7mMMeM61I3zF5P/iGIGGj6w/7CnU
         RhiceLaYy+dkXi6MzGxSNXo9QKQ/1HPd3amLveL/+ZUWdAUG78qdRaYYuiKLHzNvb/tA
         DvrJLJLY07EkIQF4fU0m6YTB1L56m0JiAtVWF2uE5I5m+xmCENI6ahqZCr4tUgavjzER
         FAcnXRmiM6xHON02AMCM5NNr3UuXn9oHkY0ILXD5GTXt2UlCkbbY3Ws4mu3pzI0btt6T
         gl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725575498; x=1726180298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByTGY4/YW1oFlLnwGbDA1qTS9L9gMEUay1+a7RZYMwo=;
        b=kDBNrhrZ0dkD5v7IRJtiAjFyg09tm371FaJvR5yU/OENc65R/fRaWdWX2nQKUyKRDL
         IV5PskFurRtqv0yoj+Dg5wlSrvnpMNfGtU1efb+lfs4c5QymTv1SiEW2aPG/VrDLTxLp
         I1zKLuDFxJx++g5AHHLS1FGq+T/Ci8z2pnt3HV2Zg/XDF/Gb1ah1884saiOBDYyyv6i6
         +VY1a+/EsAaHPgNv4iHe6wzKhlIqkb7ZFvXEqSIMa7AOSVWGiz0QXQL1E9FT5Wrp/Wgl
         i4t1C/V9md5Qc38ekhL5z/ZHwlkBDoaJz7Y4cfM9jNosl3TJmuj9fqr69Sluh2ZCuRcf
         JZ6A==
X-Forwarded-Encrypted: i=1; AJvYcCUDdmkxU7PBAmowRFLnuwDhSJyVL/Lmq/Ic3BFgJZk1r3LgAHnO2FOxhr0VRIApvD4ups9hjj4DdjpK@vger.kernel.org, AJvYcCUg6NASX53OBDbKYLyT5b0uZjmHOQLrhDNzZqFdYtDci0dCfTsEmZ44uGxaGKzbQFLy+OG9oMqc7GnC@vger.kernel.org, AJvYcCXHlkLSeX8kVz6NcgwjKhNjw8doNcQv1/zjZ1kvS/T5JKcMHIHoAsBV0qTH4iCfeKjFqu3ZrSzlc08QNAtD@vger.kernel.org
X-Gm-Message-State: AOJu0YwokCqJobPkmoUthU+f7iSBmZU8EDk0w7C5+INs3Kx8/DagDn36
	MLbSGj9snnbLsNxNq75wU8V8vnlk3IMVMe2KLb/mZHFjzfiOI/v8
X-Google-Smtp-Source: AGHT+IElrwBYH/D0EmLH69uk3BJrH7NaeKR2pAOqLsxRNAM44HDm9e8DYGn+wJTGKzyP8BcdCGua7w==
X-Received: by 2002:a05:6870:ac14:b0:277:d8ee:6dda with SMTP id 586e51a60fabf-27b82ed99acmr842093fac.23.1725575498562;
        Thu, 05 Sep 2024 15:31:38 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef1e6efsm115978685a.23.2024.09.05.15.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 15:31:38 -0700 (PDT)
Date: Thu, 5 Sep 2024 18:31:35 -0400
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
Message-ID: <w6izw3nv35zhquqipv5elp7hqf5pdtu6b2ss2infh4mmxr4aop@cxypawy5rufr>
References: <20240905124432.834831-1-lanzano.alex@gmail.com>
 <20240905124432.834831-2-lanzano.alex@gmail.com>
 <a4520c05-d64b-4ef0-823c-6c568b459e21@kernel.org>
 <trlyhlclf74itbgj4x6baj6ga6yipdicw3c6odtjgxtbw3cjyl@lyfiny2yiz35>
 <8bab34a9-0fe4-4c69-b12b-7ad663bde2d0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bab34a9-0fe4-4c69-b12b-7ad663bde2d0@kernel.org>

On Thu, Sep 05, 2024 at 11:12:47PM GMT, Krzysztof Kozlowski wrote:
> On 05/09/2024 22:27, Alex Lanzano wrote:
> > On Thu, Sep 05, 2024 at 03:23:20PM GMT, Krzysztof Kozlowski wrote:
> >> On 05/09/2024 14:43, Alex Lanzano wrote:
> >>> Add device tree bindings for the monochrome Sharp Memory LCD
> >>>
> >>> Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
> >>> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> >>> Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> >>
> >> I don't understand what happened here. Your process of handling patches
> >> is odd. Tags do not disappear, you had to remove them, right? So where
> >> is the explanation for this?
> > 
> > Whoops! My apologies for wasting time. Nothing changed in this patch
> > I forgot to add in your reviewed-by tag.
> 
> Tag was there before, so you removed it...

In prior versions I was manually adding the tag to the patch file. But I
have since added it to the commit message like I should have from the
beginning. Again, I apologize for any time wasted and appreciate the
review.

