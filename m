Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543F53AE869
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Jun 2021 13:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhFUL4I (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Jun 2021 07:56:08 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34544 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFUL4I (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Jun 2021 07:56:08 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15LBrhKW059771;
        Mon, 21 Jun 2021 06:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1624276423;
        bh=5nHxsBQDy/Mqy9USBF2x599r8UPBoh7zt5PsD3t1noc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JyPQS0WmUIN/kJyxrN8beSAIN6FIcJRcYrh7UVd53T2p6hrvlRtHyIQwrbZEseTQI
         WioROAxiUrnFnH/FF34FdOT19yzhK1rPwHkPC3WDhJKFg7nbS/iB3vM5riVn5bmP3i
         N41kI4NltTLoLXEnCl2qYRlCznl+BvJUZIqFtukI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15LBrhQD127220
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jun 2021 06:53:43 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 21
 Jun 2021 06:53:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 21 Jun 2021 06:53:42 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15LBrYSx040876;
        Mon, 21 Jun 2021 06:53:37 -0500
Subject: Re: [PATCH 0/2] dt-bindings: pwm: pwm-tiecap: Convert to json schema
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>
CC:     <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, <linux-pwm@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20210601102804.22152-1-lokeshvutla@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <a84a1fcb-b85d-975f-1763-03cd533855f1@ti.com>
Date:   Mon, 21 Jun 2021 17:23:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210601102804.22152-1-lokeshvutla@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,

On 01/06/21 3:58 pm, Lokesh Vutla wrote:
> This series:
> - converts tiecap to DT schema format using json-schema
> - Add new compatible for AM64 SoC.

If there are no objections, can we merge this series?

Thanks and regards,
Lokesh

> 
> Lokesh Vutla (2):
>   dt-bindings: pwm: pwm-tiecap: Convert to json schema
>   dt-bindings: pwm: pwm-tiecap: Add compatible string for AM64 SoC
> 
>  .../devicetree/bindings/pwm/pwm-tiecap.txt    | 51 ---------------
>  .../devicetree/bindings/pwm/pwm-tiecap.yaml   | 64 +++++++++++++++++++
>  2 files changed, 64 insertions(+), 51 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiecap.yaml
> 
