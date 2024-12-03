Return-Path: <linux-pwm+bounces-4197-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A37D99E12F8
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 06:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76304161BB6
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 05:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B260154C0B;
	Tue,  3 Dec 2024 05:41:33 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDA66FC3;
	Tue,  3 Dec 2024 05:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733204493; cv=none; b=J+jeV/rdKucwczeu9di3jAN4NseNPbtlS8jhS1SExc8ORhdLaSqqD57wT7cv8g935H4X6YbJ/mQaaygq5ynAm0muSFaNvZht1oVHg44B7cOsXu6chq2ZPJEtquTKwdbHDswTgr1GphzFIPT/DWpchn0wqIW6Kw23h1rreG1PqRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733204493; c=relaxed/simple;
	bh=8GZFjRFhTw7KFwzDIhx5sSiCpnlolH/1gFq1ywATdhk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5IqQN5JYoqOnXw9pBWbN10pJJVouudd0CmgtXehUTpapWjg3yvKan5mJI7lxmeAmJ1BVo/tMfaw72H+g29WwoCWEOkvR25tTZciG5gVHUIBAIs52bh5HEgx8Kqll9s68RigffnbKPcKzA7Y2L1DfJEeFN0FHC/gRAtlZYZEJYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 4B35fLLO025476
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Tue, 3 Dec 2024 13:41:21 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from atctrx.andestech.com (10.0.15.11) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 13:41:20 +0800
Date: Tue, 3 Dec 2024 13:41:20 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: add atcpit100-pwm
Message-ID: <Z06aAEsCHxSmDDtT@atctrx.andestech.com>
References: <20241202060147.1271264-1-ben717@andestech.com>
 <20241202060147.1271264-2-ben717@andestech.com>
 <qmbaftzr4ww35txfjvt6iao5g5jjikx5swgh6cdqbiu36dwo2y@74vnlk2a3ihn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <qmbaftzr4ww35txfjvt6iao5g5jjikx5swgh6cdqbiu36dwo2y@74vnlk2a3ihn>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 4B35fLLO025476

On Mon, Dec 02, 2024 at 08:40:22AM +0100, Krzysztof Kozlowski wrote:
> [EXTERNAL MAIL]
> 
> On Mon, Dec 02, 2024 at 02:01:46PM +0800, Ben Zong-You Xie wrote:
> > Document devicetree bindings for Andes atcpit100-pwm.
> >
> > Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
> > ---
> >  .../bindings/pwm/andestech,atcpit100-pwm.yaml | 51 +++++++++++++++++++
> >  MAINTAINERS                                   |  5 ++
> >  2 files changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml b/Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
> > new file mode 100644
> > index 000000000000..4b707f32ad72
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/andestech,atcpit100-pwm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Andes atcpit100 PWM
> > +
> > +maintainers:
> > +  - Ben Zong-You Xie <ben717@andestech.com>
> > +
> > +allOf:
> > +  - $ref: pwm.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: andestech,atcpit100-pwm
> 
> 
> Previously, before we removed it in 2022, this was just
> andestech,atcpit100, so questions:
> 
> 1. Why are you re-introducing it? Please address all the comments or
> aspects leading to removal.
> 2. Why are you using different compatible? Is this one device?
> 
> Best regards,
> Krzysztof
>

Hi Krzysztof,

1. You can first refer to the patch[1].
   The patch not only removes the support to nds32, but also removes
   Andes device driver. Though Andes now dedicates our effort on RISC-V,
   ATCPIT100 is still one of peripheral platform IPs, and that's why we are
   re-introducing it now.

2. Yes, they are the same device. ATCPIT100 is a set of compact
   multi-function timers, which can be used as PWMs or simple timers.
   I think the example in the YAML file is a little confusing because
   there are two ATCPIT100 nodes in our DTS file now:

	pit: timer@f0400000 {
		compatible = "andestech,atcpit100";
		...
		...
	};
	pwm: pwm@f0400000 {
		compatible = "andestech,atcpit100-pwm";
		...
		...
	};

   Is it better to modify our DTS file and the example in the YAML file
   like below?
	
	pit: pit@f0400000 {
		compatible = "andestech,atcpit100";
		reg = <0xf0400000, 0x1000>;
		clocks = <&smu 1>, <&smu 7>;
		clock-names = "ext", "apb";
		pwm: pwm {
			compatible = "andestech,atcpit100-pwm";
			#pwm-cells = <3>;
		};
	};

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aec499c75cf8e0b599be4d559e6922b613085f8f

Best regards,
Ben


