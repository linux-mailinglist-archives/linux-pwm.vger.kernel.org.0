Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3882218F3AB
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2020 12:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgCWLaa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Mar 2020 07:30:30 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51426 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgCWLaa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 07:30:30 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02NBULbc122352;
        Mon, 23 Mar 2020 06:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584963021;
        bh=SvZEk0kF+xXLC23PlsMzzjUziFI9pRar16wxl8TII6g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Zo1yalVtoEaB5tFIsjBmAkmnkpzZnGj5w6Rkk1p55dm58UeyWqHwIYII/MIfAgRYx
         elzBMBWoQa67uJE61S7LWn6QkG7VbcV3xOf4sTuw8U1rRboFR2jJtLdUIPtuckw5hK
         LBC6p/FqcTxsR01FV3Vn4d68bXOpr5hxXPVPaeAE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02NBUKpY087302
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Mar 2020 06:30:20 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 23
 Mar 2020 06:30:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 23 Mar 2020 06:30:16 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02NBUDtI076876;
        Mon, 23 Mar 2020 06:30:14 -0500
Subject: Re: [PATCH v3 0/5] pwm: omap-dmtimer: Allow for dynamic pwm period
 updates
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <09dac13d-44b0-80c6-fdbb-54bfc6f48e36@ti.com>
Date:   Mon, 23 Mar 2020 17:00:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200312042210.17344-1-lokeshvutla@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi All,

On 12/03/20 9:52 AM, Lokesh Vutla wrote:
> This series fixes minor issues in config callback and allows for on the
> fly updates for pwm period and duty cycle. This is mainly intended to
> allow pwm omap dmtimer to be used for generating a 1PPS signal that can be
> syncronized to PTP clock in CPTS module available in AM335x and AM57xx SoCs.
> 
> Series depends on the following series:
> - https://patchwork.kernel.org/patch/11379875/
> - https://patchwork.kernel.org/project/linux-omap/list/?series=251691

Gentle ping on this series :) The above dependencies are merged into timer tree
and below is the immutable branch:

https://git.linaro.org/people/dlezcano/linux.git/log/?h=timers/drivers/timer-ti-dm

Thanks and regards,
Lokesh
