Return-Path: <linux-pwm+bounces-4797-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4569A2A35B
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 09:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEEA71889316
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 08:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024C222578B;
	Thu,  6 Feb 2025 08:39:38 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6111822577D;
	Thu,  6 Feb 2025 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831177; cv=none; b=MUrhQv6++noeSvbrjsQQaAb6AOnQyn2U1U7ayfx6d76DZ01pcnXt/uvfAJQkwc8XyOOx3IW4CdXrS6IK615eQcwR3pXzLiB2KKdgGtyKHKlVUIVMOhbzsXRN9V3hJj3T3texh0yvJ5EpXFRB0bONqhLavFEk5mpCzurFjiB9jYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831177; c=relaxed/simple;
	bh=NY5KMo4mSbDM2oc+61t64xOvH/Rr8aNKNrVv+vLhO9o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwzPCfVJTU0+jri+lc7qd97cOUW5GH+OWtnEoacokhp53gqV1jC3bDQx2B2+GTEH1AFL6PebkU+zjZQAkG0ZAHKJgVvYWkTlbR15iCnUytshS1GwJ8rUr61WR+u4k+W4cDrV8bIYNhP/w7mw4WeTLvWxC6MibLQ0kF+zpAHjK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 51689QX5012700;
	Thu, 6 Feb 2025 16:09:26 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 51688w6s012525
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Thu, 6 Feb 2025 16:08:58 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from atctrx.andestech.com (10.0.15.11) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 16:08:58 +0800
Date: Thu, 6 Feb 2025 16:08:58 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: <krzk@kernel.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ukleinek@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <ben717@andestech.com>
Subject: Re: [v3 2/2] pwm: atcpit100: add Andes PWM driver support
Message-ID: <Z6RuGrszOiPFWHyU@atctrx.andestech.com>
References: <20250123193534.874256-1-ben717@andestech.com>
 <20250123193534.874256-3-ben717@andestech.com>
 <5514fa03-139e-456e-b522-6a774b52eac1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5514fa03-139e-456e-b522-6a774b52eac1@kernel.org>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 51689QX5012700

On Fri, Jan 24, 2025 at 08:30:48AM +0100, Krzysztof Kozlowski wrote:
> [EXTERNAL MAIL]
> 
> On 23/01/2025 20:35, Ben Zong-You Xie wrote:
> >
> > +config PWM_ATCPIT100
> > +     tristate "Andes ATCPIT100 PWM support"
> > +     depends on OF && HAS_IOMEM
> > +     depends on RISCV || COMPILE_TEST
> > +     select REGMAP_MMIO
> > +     help
> > +       Generic PWM framework driver for ATCPIT100 on Andes AE350 platform
> 
> 
> Is AE350 a type of a SoC? Looks like. "depends on RISCV" is wrong -
> there is nothing RISC-V specific here. You must depend on given
> SoC/platform.
> 

Hi Krzysztof,

AE350 is not a SoC. It's just a reference platform to verify Andes CPUs
on FPGA. For further information on AE350, please refer to [1].

Also, I will remove "depends on RISCV" and fix the coding style problems
in the next patch. Thanks for your review.

[1] https://www.andestech.com/en/products-solutions/andeshape-platforms/ae350-axi-based-platform-pre-integrated-with-n25f-nx25f-a25-ax25/

Best regards,
Ben

> > +
> > +       The ATCPIT100 Programmable Interval Timer (PIT) is a set of compact
> > +       multi-function timers, which can be used as pulse width
> > +       modulators (PWM) as well as simple timers. ATCPIT100 supports up to 4
> > +       PIT channels. Each PIT channel can be a simple timer or PWM, or a
> > +       combination of timer and PWM.
> > +
> > +       To compile this driver as a module, choose M here: the module
> 
> 
> ...
> 


