Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBB986172
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Aug 2019 14:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfHHMPA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Aug 2019 08:15:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37418 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfHHMPA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Aug 2019 08:15:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so90579951eds.4
        for <linux-pwm@vger.kernel.org>; Thu, 08 Aug 2019 05:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3XH58oe3b9t1OK4zp9oXg6yL++7sd5XsM6HbIEdCObA=;
        b=S06kqlDaJg3bUAnddRccppNaWWbq8+EZWufL3MtPEs/y1B2/iaY6/hc+2CTHIxSTOj
         Ci8YxFTpEZpTNOIJn7FWzBX7bsiwzMi1tZdTc6ggGauR1DJv5YXPf0v3Upypz9MR/N9f
         NQTD37BJ/djyx8Hrg5GQEIrnGDc6hM7v9MchCuA0kLPuvNWUIQIKPyIg0PyVWNrvCaLO
         hwgPq7dsaiTk8zZO5La3uKMluTS3i67sProGBbMIkpE+9ky7lNRp9KlHDcowsM5yCv6S
         eGobm/nsVVbt6zbgihddLJTanSY6g51YU1ab70LDF+WXUq+1gYmm1gNcvlqnRh8TFeKJ
         Incw==
X-Gm-Message-State: APjAAAXZ+f5Wa8yo51kpUznyovBrpniaEKge4qQv3qFlasUs34msDEKI
        tMX1sAfs7kcWuTuJwb3twVIiWA==
X-Google-Smtp-Source: APXvYqyOkS6n7hpVdf4W7PVVLiuHAK954qcuqUs+vn7hlgIkI/3+iYgxVpJ4HMnXe4R1lXHqoN58Bg==
X-Received: by 2002:a17:906:4e95:: with SMTP id v21mr4939724eju.105.1565266498690;
        Thu, 08 Aug 2019 05:14:58 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s2sm8457858ejf.11.2019.08.08.05.14.57
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 05:14:57 -0700 (PDT)
Subject: Re: [PATCH 5.3 regression fix] pwm: Fallback to the static
 lookup-list when acpi_pwm_get fails
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org,
        youling257@gmail.com,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
References: <20190730154848.5164-1-hdegoede@redhat.com>
 <31c3f15e-649e-a3c1-56e2-0c35fda24ae1@redhat.com>
 <20190808112122.GB24700@ulmo>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <71bc5280-46e8-77ad-004e-8a9b3befa7d1@redhat.com>
Date:   Thu, 8 Aug 2019 14:14:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808112122.GB24700@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 08-08-19 13:21, Thierry Reding wrote:
> On Thu, Aug 08, 2019 at 12:19:53PM +0200, Hans de Goede wrote:
>> Thierry,
>>
>> Ping? This fixes a somewhat serious regression in 5.3, can we please get
>> this queued up for merging into 5.3 ?
> 
> I've pushed this out. Let's give it a day in linux-next and then I'll
> send out a PR for v5.3-rc4.

Great, thank you.

Regards,

Hans

