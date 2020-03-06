Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 453D917B8ED
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Mar 2020 10:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgCFJDp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Mar 2020 04:03:45 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15809 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgCFJDp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Mar 2020 04:03:45 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e6211990007>; Fri, 06 Mar 2020 01:02:17 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 06 Mar 2020 01:03:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 06 Mar 2020 01:03:44 -0800
Received: from [10.19.64.157] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Mar
 2020 09:03:41 +0000
Subject: Re: [PATCH] pwm: tegra: Add support for Tegra194
To:     Sandipan Patra <spatra@nvidia.com>, <treding@nvidia.com>,
        <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <jonathanh@nvidia.com>
References: <1583407653-30059-1-git-send-email-spatra@nvidia.com>
CC:     <bbasu@nvidia.com>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Laxman Dewangan <ldewangan@nvidia.com>
Message-ID: <cc4daacd-c9fb-8057-dad3-7411476e4757@nvidia.com>
Date:   Fri, 6 Mar 2020 14:33:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1583407653-30059-1-git-send-email-spatra@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583485338; bh=vzioGjXD1IUumga+3XM/dUEThHitYjhisxYt6UDi4fk=;
        h=X-PGP-Universal:Subject:To:References:CC:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding;
        b=UWX8JX+xbXvTj+Ob23BujOnEyiFtcPUAG7A2WX+W2NmeJxE23xXYhug9LwFbj7DX0
         1uwdFYLQLMUtN2vozAEjzRNNql/5hla1B4Ym7glTI+SW5X2ruL3qDnCXUZQcTJainN
         g1TTOYxPvLv7py8zLLWc0A+NHzA2OnYuCWDkzRXKEDGqYftA7ziHhC0+BhhwsVSokK
         uof2WppWcN8u3UvSJ7fx5KESnk3pluHEY83HDwCaFOqypL1OE0/k7UG1RYWuJZHSX9
         FFnb3ELBac8jsK7xbAOfcfwhL3RjK1jJw25b3npGt3tnWSgSzPqttxlwUd+Fruj6Hi
         KxB2medoPXObQ==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On Thursday 05 March 2020 04:57 PM, Sandipan Patra wrote:
> Tegra194 has multiple PWM controllers with each having only one output.
>
> Also the maxmimum frequency is higher than earlier SoCs.
>
> Add support for Tegra194 and specify the number of PWM outputs and
> maximum supported frequency using device tree match data.
>
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
>   Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 1 +
>   drivers/pwm/pwm-tegra.c                                      | 6 ++++++
>   2 files changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> index 0a69ead..74c41e3 100644
> --- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> @@ -9,6 +9,7 @@ Required properties:
>     - "nvidia,tegra132-pwm", "nvidia,tegra20-pwm": for Tegra132
>     - "nvidia,tegra210-pwm", "nvidia,tegra20-pwm": for Tegra210
>     - "nvidia,tegra186-pwm": for Tegra186
> +  - "nvidia,tegra194-pwm": for Tegra194
>   - reg: physical base address and length of the controller's registers
>   - #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
>     the cells format.
>

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
