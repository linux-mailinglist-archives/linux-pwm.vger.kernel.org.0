Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845C3242461
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Aug 2020 05:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgHLDtT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Aug 2020 23:49:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:61195 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgHLDtT (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 11 Aug 2020 23:49:19 -0400
IronPort-SDR: LOSgJmXI1rGPGmMW+M2QPDyaZJTsWxPM97B8kb2NbqlJnBD/E4yJ9HGmmiBrzYlUg5bVLJkYnZ
 q2JoL7SlK3iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="153101737"
X-IronPort-AV: E=Sophos;i="5.76,302,1592895600"; 
   d="scan'208";a="153101737"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 20:49:18 -0700
IronPort-SDR: yqj+TjlD8G/AgumHzWcCQrb5ZE2y9lZmS1AS9z4aKP7zV/S3ygX5vcHNqLr3nX5dFZa5lKCmxD
 BHE+blLlPAiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,302,1592895600"; 
   d="scan'208";a="317951295"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2020 20:49:18 -0700
Received: from [10.214.175.153] (rtanwar-MOBL.gar.corp.intel.com [10.214.175.153])
        by linux.intel.com (Postfix) with ESMTP id 7D212580609;
        Tue, 11 Aug 2020 20:49:15 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] Add DT bindings YAML schema for PWM fan controller
 of LGM SoC
To:     Rob Herring <robh@kernel.org>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com
References: <cover.1595926036.git.rahul.tanwar@linux.intel.com>
 <e61e6a05353f6242f5450da130b042f195ac7620.1595926036.git.rahul.tanwar@linux.intel.com>
 <20200731181944.GB516550@bogus>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <e50f198d-42d4-28b1-d32c-32f4b1bbcb0b@linux.intel.com>
Date:   Wed, 12 Aug 2020 11:49:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200731181944.GB516550@bogus>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi Rob,

On 1/8/2020 2:19 am, Rob Herring wrote:
> On Tue, Jul 28, 2020 at 04:52:12PM +0800, Rahul Tanwar wrote:
>> Intel's LGM(Lightning Mountain) SoC contains a PWM fan controller
>> which is only used to control the fan attached to the system. This
>> PWM controller does not have any other consumer other than fan.
>> Add DT bindings documentation for this PWM fan controller.
>>
>> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
>> ---
>>  .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     | 54 ++++++++++++++++++++++
>>  1 file changed, 54 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
>> new file mode 100644
>> index 000000000000..9879972470dc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
>> @@ -0,0 +1,54 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/intel,lgm-pwm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: LGM SoC PWM fan controller
>> +
>> +maintainers:
>> +  - Rahul Tanwar <rahul.tanwar@intel.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: intel,lgm-pwm
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#pwm-cells":
>> +    const: 2
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  intel,fan-wire:
>> +    $ref: '/schemas/types.yaml#/definitions/uint32'
>> +    description: Specifies fan mode. Default when unspecified is 2.
>> +
>> +  intel,max-rpm:
>> +    $ref: '/schemas/types.yaml#/definitions/uint32'
>> +    description:
>> +      Specifies maximum RPM of fan attached to the system.
>> +      Default when unspecified is 4000.
> Again, these are properties of a fan, not the pwm controller. They 
> belong in a fan node.

Our PWM controller is actually a PWM fan controller dedicated for
controlling fan. I am looking for some suggestions from you on how
to handle fan related optional properties in such a scenario.

Should i create a separate child node for fan with PWM node being
the parent? Is that what you are suggesting? Thanks.

Regards,
Rahul

