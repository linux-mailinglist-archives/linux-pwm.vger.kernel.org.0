Return-Path: <linux-pwm+bounces-5363-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A144FA7E09C
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 16:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 705307A3CD4
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0191CAA86;
	Mon,  7 Apr 2025 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLsODXQ6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6BE1C5F28;
	Mon,  7 Apr 2025 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035081; cv=none; b=NG3x+fVuizKnoU/msvmlcMvS7khz+hPPe2uklRqnPI7y2VQOYwON3+eeKe41zh6DGjvxqbCX1rVFbm2CW3c2MibpD38tZ6SKDmeVVROzumotOhTzZyAIyv9P22nkWx1YxGfN0b2j4TXg2agzrGpVBn8QgNXHeOBVhW16ziTNdbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035081; c=relaxed/simple;
	bh=kZUcAvHfg06pFUq3u0ppbMfjOjpMz7azG1mzNbRZCds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUYuEBc+eNz7U5o/BIO7Ei1XxcEMaQ+hrXK6GLPNypJR9+5av+fGyerui1WNpJO9wN+cXXivaTmNNGwX5UhnTXiuwWXEZRpQCd2zWPEnMroC+91h9NjHsqxbqyjuxrSTuYO9jlIfC5SNjoVplj9pje9xxvZPs9IcZ2rJCgWrdVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLsODXQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB2DC4CEDD;
	Mon,  7 Apr 2025 14:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744035081;
	bh=kZUcAvHfg06pFUq3u0ppbMfjOjpMz7azG1mzNbRZCds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLsODXQ6hUQvST6rpsd/56i2NZHg4QFuam+7YuMAvAIqqHs/DGMFXjuYdR4B1eqpj
	 YQv+Zzut5lVsD/IqFdy+OvkoUmg+nxGgxkNDzlSffilACynbqFCaJzH2T5VPbMk3gn
	 bUXhyDAV04SgHJLpTupeVxzpp1JVNo1MWsNu0VKOGgeEHcogj7ah3whTPAw0ciqmX+
	 fq5op1+7RJJqaBu0+zDC2ZqoZxbByLbBc8quTJJpOtfMcP7tTBT2zKbEz68LDjNLSm
	 FDYAeMPbbiuxsDUsfWADTCCXXvY/BXjMhjG+lNksaFW/dptlXhp0HGXvrPNp4H7SXg
	 hVXNSPW2k/zSA==
Date: Mon, 7 Apr 2025 09:11:19 -0500
From: Rob Herring <robh@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Longbin Li <looong.bin@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	ghost <2990955050@qq.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: sophgo: add pwm controller for
 SG2044
Message-ID: <20250407141119.GA2192351-robh@kernel.org>
References: <20250407072056.8629-1-looong.bin@gmail.com>
 <20250407072056.8629-2-looong.bin@gmail.com>
 <jq55x7uhftvejninh56tzk32jtmmwa5wxzna5uxbkk5woi7zi5@6wrg2ctmyg7b>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jq55x7uhftvejninh56tzk32jtmmwa5wxzna5uxbkk5woi7zi5@6wrg2ctmyg7b>

On Mon, Apr 07, 2025 at 02:31:24PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Apr 07, 2025 at 03:20:38PM +0800, Longbin Li wrote:
> > diff --git a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> > index bbb6326d47d7..e0e91aa237ec 100644
> > --- a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> > @@ -17,7 +17,9 @@ allOf:
> > 
> >  properties:
> >    compatible:
> > -    const: sophgo,sg2042-pwm
> > +    enum:
> > +      - sophgo,sg2042-pwm
> > +      - sophgo,sg2044-pwm
> 
> Given that the sg2044 has more registers (to e.g. implement different
> polarity), but the sg2042 registers are identical, I wonder if the 2044
> device should use:
> 
> 	compatible = "sophgo,sg2044-pwm", "sophgo,sg2042-pwm";
> 
> Note, I'm unsure here, only providing input to people who are more
> knowledgeable in DT that I am.

Depends if s/w only understanding "sophgo,sg2042-pwm" will work on the 
2044. IOW, will a kernel without the driver change here work?

Rob

