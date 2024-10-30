Return-Path: <linux-pwm+bounces-3981-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56169B6B8F
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Oct 2024 19:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A218281347
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Oct 2024 18:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ACA19E83C;
	Wed, 30 Oct 2024 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgGnQw5O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779641BD9F6;
	Wed, 30 Oct 2024 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730311360; cv=none; b=PUdGUOZkNCY7rdaZjd82bNgXCilcri+mS+t+3hVHSqHRHkloUJxnTyhG74EJnjdSlu6mJ4RLAUNWdnd4K+p0iulvS+pDk1oybxVsJGqlz1L9tr7N8nymeE2YldhbWvfNsPdUJgqmAUwS5J0ZTQMf/1oaEKC3qEljs/RH1zSH++o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730311360; c=relaxed/simple;
	bh=VJQ/ae3Mkm9u4W2mXTamHVBG9ReQzeVjbtwnNX/s1bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEvOsqIN8fXsOmXOPAPpvUc7j2uDsqEWQccNpaWT34K+bIuAyyc70MYwSTBsMKEmpWSBpLv3ZSjobyQ9FEWRqC+P23UCySrBdM0yGhRQNJNC1fY2QZxaLTxrA/g1SEmQJlWgUwqZLuwyV/tciwQmLVsvmSkcRoGRq9UqktcOJ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgGnQw5O; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99ebb390a5so223098066b.1;
        Wed, 30 Oct 2024 11:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730311357; x=1730916157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJQ/ae3Mkm9u4W2mXTamHVBG9ReQzeVjbtwnNX/s1bA=;
        b=TgGnQw5OlOBqhPrBJntHRNZ1ZNAmKWybucs91k+LWLtmpWa88XE1iS10QxPeuwfaA/
         FaPVqK2YZZcqeJgoyY41YhcqP7elf9fqx7rog1wycSbuzII7qBsuKs14NO7j2eKTLO4s
         gM2yoWTP2+MUdIeAoSSTi5l71lzCeq0kOpDmqzlCz500T7YgN27cdN7oYMiQdqsKQEHv
         um/WByjP0ih0j0I6Z9XywEHirr348rRj3dmA05k6Q5MAiUA4/aFSTzhRym9pNfAPrVSY
         aCjPWDFYwHUufdLr1a7srxM8w4rLhzW03gqmSDgQg9revbGdDg8KIKCrsLdZG2dR8b9E
         MsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730311357; x=1730916157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJQ/ae3Mkm9u4W2mXTamHVBG9ReQzeVjbtwnNX/s1bA=;
        b=PpjV18NbR5Z3KBd/oe+Qw2uoc/sbV6TgyozOScle6cedWKM9I3ipJUIPyB2irh5Hz1
         gWii2rPANkKsBhQIH+Pxitkkyp5yr/3L1xikvZwmCJAqlGvYFX1kheWlJWJY9ZU4RdKr
         zgE/7V+uonCXW0psOEnw4SSXhWAFj6saVFHYU4pPsUnWOSe+ClTYJc4MRdURshtAk20x
         j+2oh5q8XGbutUGrqHQ1SpI4EVpCjvTr6SYXKqVI1UOTCoZXwbamO+hlBeThoAM9sFwf
         Ly+eAgY0xs00h2FqGHcDQGgXPVweGqf0HupJw0WyUmLmzx/VgkywMzcEc40JG/0Wqarg
         mZ/A==
X-Forwarded-Encrypted: i=1; AJvYcCW7pwMY7bE/iWfnvV+mIXjvJu2TJYVTtJd/QPNJCQzRJdrMEO84RCgEw3y5xKlVXCwrrAg0QFSRn3wt@vger.kernel.org, AJvYcCXZtvNb5ScdiCRfkE03uWCPqmeCVXw0PkjqAMn98fCM5t2FdpY2iNZh+vrpPkcYgNx/tFavzWlQq8lAYRnZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxqoAzEHazVaGQPKDF+GDrt1UwQtW+cXFJLd7ex51iRLNINqebV
	rQ/f8N3WRTqG66dHsncD2z1BVhjqn2Jopa4HtLahpW/lQIlWpyoS
X-Google-Smtp-Source: AGHT+IF+mYI8VI7ar3ka2bquEPNqWDRXFq5nmJD1BFj5bnn2DHWR0Vq2CYNy5B+wSmVbI6T2f/gyXQ==
X-Received: by 2002:a17:907:3f9d:b0:a9a:1d85:9d31 with SMTP id a640c23a62f3a-a9e2b5a4bf2mr579117466b.21.1730311356572;
        Wed, 30 Oct 2024 11:02:36 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f298d8fsm588258366b.112.2024.10.30.11.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 11:02:36 -0700 (PDT)
Date: Wed, 30 Oct 2024 19:02:34 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Wenhua Lin <wenhua.lin1994@gmail.com>,
	Wenhua Lin <Wenhua.Lin@unisoc.com>,
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
	Zhaochen Su <zhaochen.su29@gmail.com>,
	Zhaochen Su <Zhaochen.Su@unisoc.com>,
	Xiaolong Wang <Xiaolong.Wang@unisoc.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: sprd,ums512-pwm: convert to YAML
Message-ID: <ZyJ0urvkMZVzZa7S@standask-GA-A55M-S2HP>
References: <ZyH-JASRcpMXYsmH@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyH-JASRcpMXYsmH@standask-GA-A55M-S2HP>

Hi all,

just noticed this older patch [1] doing the same conversion, so I've also
CC'd other people from that patch series.

[1] https://lore.kernel.org/lkml/20240125025533.10315-5-Wenhua.Lin@unisoc.com/

Sorry for the noise,
Stanislav

