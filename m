Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1FD3973C8
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jun 2021 15:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbhFANGt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Jun 2021 09:06:49 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58482 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbhFANGs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Jun 2021 09:06:48 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 151D4x0Z106173;
        Tue, 1 Jun 2021 08:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622552699;
        bh=naX3kstdCVTukTs526qUtm1q78sZy0YnorByIZb+vlo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YE4glL+XSB393NoUQKgZkWYIfnA0HjKPoj8IFa2SPx46HBav5Z2tP93b8urvwSnyh
         hpHFhrBFGIgy7vB3GZFN/POjZ6alUe20HYLAuihqEQHSQ8dEuH3vf30wlTvLVaC3pU
         8fuiFRxPLzTmUqHUSmsjkoGGBbpriWjA6uujTh10=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 151D4xfB125250
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Jun 2021 08:04:59 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 1 Jun
 2021 08:04:59 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 1 Jun 2021 08:04:59 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 151D4u4t118350;
        Tue, 1 Jun 2021 08:04:56 -0500
Subject: Re: [PATCH v3] arm: dts: ti: drop usage of redundant compatible
To:     Lokesh Vutla <lokeshvutla@ti.com>, Rob Herring <robh+dt@kernel.org>
CC:     <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Vignesh R <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        <linux-pwm@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>
References: <20210601054029.1839-1-lokeshvutla@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <b6b1277c-916f-49b9-cc63-1235a0c35b02@ti.com>
Date:   Tue, 1 Jun 2021 16:04:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210601054029.1839-1-lokeshvutla@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 01/06/2021 08:40, Lokesh Vutla wrote:
> Commit 229110c1aa691 ("ARM: dts: am437x/am33xx/da850: Add new ECAP and
> EPWM bindings") added ti,am3352-ehrpwm compatible which is similar to
> ti,am33xx-ehrpwm but without out t,hwmod properties. But with commit
> 58bfbea5b1c68 ("ARM: dts: am437x/am33xx: Remove hwmod entries for ECAP
> and EPWM nodes") dropped support for all ti,hwmod for ehrpwm, but
> missed deprecating ti,am33xx-ehrpwm compatible. So drop ti,am33xx-ehrpwm
> from DT as it is no longer needed.
> 
> ti-ehrpwn driver still support ti,am33xx-ehrpwm in order to maintain
> backward compatibility.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Changes since v2:
> - Split from ehrpwm yaml conversion series:
>    https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=489981
> - Dropped documentation update in this patch.
> 
>   arch/arm/boot/dts/am33xx-l4.dtsi |  9 +++------
>   arch/arm/boot/dts/am437x-l4.dtsi | 18 ++++++------------
>   arch/arm/boot/dts/da850.dtsi     |  6 ++----
>   3 files changed, 11 insertions(+), 22 deletions(-)
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
